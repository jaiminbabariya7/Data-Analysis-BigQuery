.PHONY: load run lint clean
# Usage: make load PROJECT_ID=my-project && make run PROJECT_ID=my-project
PROJECT_ID ?= $(shell gcloud config get-value project)

load:
	bq --project_id=$(PROJECT_ID) mk -f --dataset customer_data
	bq --project_id=$(PROJECT_ID) load --replace --autodetect --source_format=CSV \
		customer_data.raw_customer_table data/customer_shopping_data.csv
	sed "s/PROJECT_ID/$(PROJECT_ID)/g" sql/00_create_typed_table.sql | bq --project_id=$(PROJECT_ID) query --use_legacy_sql=false

run:
	for f in sql/total_sales_by_category.sql sql/total_sales_by_payment_method.sql \
	         sql/average_purchase_by_segment.sql sql/window_functions.sql; do \
		echo "== $$f"; sed "s/PROJECT_ID/$(PROJECT_ID)/g" $$f | bq --project_id=$(PROJECT_ID) query --use_legacy_sql=false; \
	done

lint:
	sqlfluff lint sql/ || echo "sqlfluff not installed - run: pip install sqlfluff"

clean:
	rm -rf .sqlfluff_cache/
