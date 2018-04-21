from __future__ import absolute_import, print_function, unicode_literals

import csv
import io
import json
import xmltodict
import requests

# get_atdw_products - get products from a list in a csv
# run 
# pip install -r requirements.txt
# then you can run
# python ./get_atdw_products.py

# Pagination params - http://developer.atdw.com.au/ATLAS/API/ATDWO-search.html#pgesize
PAGE_SIZE = 100
API_KEY = "dee778a6a05e48178e2633ca92e73fb4"

terms = []

with open('terms.csv', "rU") as file:
    reader = csv.reader(
        file,
        delimiter=str(u',').encode('utf-8'),
    )
    for row in reader:
        for column in row:
            if len(column) != 0:
                terms.append(column)

with open('atdw_products.csv', 'wb') as csvfile:
    writer = csv.writer(
        csvfile,
        delimiter=str(u',').encode('utf-8'),
        quotechar=str(u'"').encode('utf-8'),
        quoting=csv.QUOTE_MINIMAL
    )

    writer.writerow(["id","image_url"])

    for term in terms:
        url = "http://atlas.atdw-online.com.au/api/atlas/products?key={}&term={}&size={}".format(API_KEY, terms[0], PAGE_SIZE)
        payload = {}

        response = requests.get(url, data=json.dumps(payload))

        response = xmltodict.parse(
            response.text,
        )

        number_of_results = response['atdw_search_response']['number_of_results']
        products = response['atdw_search_response']['products']['product_record']

        for product in products:
            # for debugging
            # import ipdb; ipdb.set_trace()

            writer.writerow(
                [
                    product["product_id"],
                    product["product_image"]
                ]
            )
