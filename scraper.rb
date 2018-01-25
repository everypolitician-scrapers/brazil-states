#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'scraperwiki'
require 'wikidata/fetcher'
require 'wikidata/area'

query = <<QUERY
  SELECT DISTINCT ?item
  WHERE
  {
    ?item wdt:P31/wdt:P279* wd:Q10864048 ; wdt:P17 wd:Q155 .
    MINUS { ?item wdt:P576 [] }
  }
QUERY

wanted = EveryPolitician::Wikidata.sparql(query)
raise 'No ids' if wanted.empty?

data = Wikidata::Areas.new(ids: wanted).data
ScraperWiki.save_sqlite(%i(id), data)
