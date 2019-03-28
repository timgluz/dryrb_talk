aws_profile ?= "staging"

pwd = $(PWD)
exts_file_name = mysql_ext.zip
vendor_file_name = vendor.zip

zip:
	rm -f tmp/deploy.zip
	zip -q -r tmp/deploy.zip . -x .git/\*

zip_mysql:
	echo "Packing compiled native extensions"
	zip -r $(exts_file_name) ./ruby/

zip_vendor:
	echo "Packaging vendor folder"
	zip -r $(vendor_file_name) ./vendor/bundle

clean:
	rm -rf .bundle/*
	rm -rf tmp/*
	rm -rf ruby/*
	rm -rf vendor
	rm -f $(exts_file_name)
	rm -f $(vendor_file_name)

compile_vendor:
	docker run --rm -v "$(pwd)":/var/task lambci/lambda:build-ruby2.5 bundle install --path="vendor/bundle" --without development test

compile_exts_old:
	docker run --rm -v "$(pwd)":/var/task lambci/lambda:build-ruby2.5 bundle install --path=. --gemfile Gemfile.exts

compile_mysql:
	docker run -v "$(pwd)":/var/task -it lambci/lambda:build-ruby2.5 /bin/bash \
		-c "yum -y install mysql-devel ; bundle install --path=. --gemfile Gemfile.exts"

build_mysql:
	docker run -v "$(pwd)":/var/task -it lambci/lambda:build-ruby2.5 /bin/bash \
		-c "yum -y install mysql-devel ; bundle install --path=. --gemfile Gemfile.exts; cp /usr/lib64/mysql/libmysqlclient.so.18 lib/;"

publish_vendor_layer:
	echo "Publishing vendor layer"
	aws lambda publish-layer-version \
		--profile $(aws_profile) \
		--layer-name genoserv-vendor-layer \
		--description "production gems" \
		--license-info "Creditshelf" \
		--compatible-runtimes ruby2.5 \
		--zip-file fileb://$(pwd)/$(vendor_file_name)

publish_mysql_layer:
	echo "Publishing new layer"
	aws lambda publish-layer-version \
		--profile $(aws_profile) \
		--layer-name mysql_0_5_1 \
		--description "Mysql native extension, version ~> 0.5.1" \
		--license-info "Creditshelf" \
		--compatible-runtimes ruby2.5 \
		--zip-file fileb://$(pwd)/$(exts_file_name)

deploy_mysql_layer: clean compile_mysql zip_mysql publish_mysql_layer
	echo "Done"

deploy_vendor: clean compile_vendor zip_vendor publish_vendor_layer
	echo "Done"

deploy: clean
	SLS_DEBUG=* sls deploy --stage=$(aws_profile)
