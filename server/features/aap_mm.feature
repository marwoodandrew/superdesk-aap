Feature: AAP Multimedia Feature

  @auth
  Scenario: Can search multimedia
    Given "search_providers"
	    """
        [{"search_provider": "aapmm", "source": "aapmm", "config": {"password":"", "username":""}}]
	    """
    Given "vocabularies"
        """
        [{"_id" : "crop_sizes",
            "display_name" : "Image Crop Sizes",
            "items" : [
                {
                    "width" : 800,
                    "is_active" : true,
                    "height" : 600,
                    "name" : "4-3"
                },
                {
                    "width" : 1280,
                    "is_active" : true,
                    "height" : 720,
                    "name" : "16-9"
                }
            ],
            "unique_field" : "name",
            "schema" : {
                "name" : {
                    "required" : true,
                    "type" : "string"
                },
                "height" : {
                    "type" : "integer"
                },
                "width" : {
                    "type" : "integer"
                }
            }
        }]
        """
    When we get "aapmm"
    Then we get list with +1 items

  @auth
  Scenario: Can search fetch from
    Given "search_providers"
	    """
        [{"search_provider": "aapmm", "source": "aapmm", "config": {"password":"", "username":""}}]
	    """
    And "desks"
        """
        [{"name": "Sports"}]
        """
        Given "vocabularies"
        """
        [{"_id" : "crop_sizes",
            "display_name" : "Image Crop Sizes",
            "items" : [
                {
                    "width" : 800,
                    "is_active" : true,
                    "height" : 600,
                    "name" : "4-3"
                },
                {
                    "width" : 1280,
                    "is_active" : true,
                    "height" : 720,
                    "name" : "16-9"
                }
            ],
            "unique_field" : "name",
            "schema" : {
                "name" : {
                    "required" : true,
                    "type" : "string"
                },
                "height" : {
                    "type" : "integer"
                },
                "width" : {
                    "type" : "integer"
                }
            }
        }]
        """
    When we post to "search_providers_proxy?repo=#search_providers._id#"
        """
        {"guid": "20150329001116807745", "desk": "#desks._id#"}
        """
    Then we get response code 201
    When we get "/archive?q=#desks._id#"
    Then we get list with 1 items
        """
        {"_items": [
      	  {
      		  "family_id": "20150329001116807745",
      		  "ingest_id": "20150329001116807745",
      		  "operation": "fetch",
      		  "sign_off": "abc",
      		  "byline": "Julian Smith/AAP PHOTOS",
      		  "firstcreated": "2015-03-29T08:49:44+0000"
      	  }
        ]}
        """
    Then we get no "dateline"

  @auth
  Scenario: Can search credit and type facets
    Given "search_providers"
	    """
        [{"search_provider": "aapmm", "source": "aapmm", "config": {"password":"", "username":""}}]
	    """
        Given "vocabularies"
        """
        [{"_id" : "crop_sizes",
            "display_name" : "Image Crop Sizes",
            "items" : [
                {
                    "width" : 800,
                    "is_active" : true,
                    "height" : 600,
                    "name" : "4-3"
                },
                {
                    "width" : 1280,
                    "is_active" : true,
                    "height" : 720,
                    "name" : "16-9"
                }
            ],
            "unique_field" : "name",
            "schema" : {
                "name" : {
                    "required" : true,
                    "type" : "string"
                },
                "height" : {
                    "type" : "integer"
                },
                "width" : {
                    "type" : "integer"
                }
            }
        }]
        """
    When we get "/aapmm?source={"post_filter":{"and":[{"terms":{"type":["picture"]}},{"terms":{"credit":["aapimage"]}}]},"query":{"filtered":{}},"size":48}"
    Then we get list with +1 items

  @auth
  Scenario: Can search categories facets
    Given "search_providers"
	    """
        [{"search_provider": "aapmm", "source": "aapmm", "config": {"password":"", "username":""}}]
	    """
        Given "vocabularies"
        """
        [{"_id" : "crop_sizes",
            "display_name" : "Image Crop Sizes",
            "items" : [
                {
                    "width" : 800,
                    "is_active" : true,
                    "height" : 600,
                    "name" : "4-3"
                },
                {
                    "width" : 1280,
                    "is_active" : true,
                    "height" : 720,
                    "name" : "16-9"
                }
            ],
            "unique_field" : "name",
            "schema" : {
                "name" : {
                    "required" : true,
                    "type" : "string"
                },
                "height" : {
                    "type" : "integer"
                },
                "width" : {
                    "type" : "integer"
                }
            }
        }]
        """
    When we get "/aapmm?source={"post_filter":{"and":[{"terms":{"anpa_category.name":["news"]}}]},"query":{"filtered":{}},"size":48}"
    Then we get list with +1 items

  @auth
  Scenario: Can search last week
    Given "search_providers"
	    """
        [{"search_provider": "aapmm", "source": "aapmm", "config": {"password":"", "username":""}}]
	    """
    When we get "/aapmm?source={"post_filter":{"and":[{"range":{"firstcreated":{"gte":"now-1w"}}}]},"query":{"filtered":{}},"size":48}"
    Then we get list with +1 items

  @auth
  Scenario: Can search date range
    Given "search_providers"
	    """
        [{"search_provider": "aapmm", "source": "aapmm", "config": {"password":"", "username":""}}]
	    """
    Given "vocabularies"
        """
        [{"_id" : "crop_sizes",
            "display_name" : "Image Crop Sizes",
            "items" : [
                {
                    "width" : 800,
                    "is_active" : true,
                    "height" : 600,
                    "name" : "4-3"
                },
                {
                    "width" : 1280,
                    "is_active" : true,
                    "height" : 720,
                    "name" : "16-9"
                }
            ],
            "unique_field" : "name",
            "schema" : {
                "name" : {
                    "required" : true,
                    "type" : "string"
                },
                "height" : {
                    "type" : "integer"
                },
                "width" : {
                    "type" : "integer"
                }
            }
        }]
        """
    When we get "/aapmm?source={"post_filter":{"and":[{"range":{"firstcreated":{"lte":"2015-09-01T14:00:00+00:00","gte":"2015-08-31T14:00:00+00:00"}}}]},"query":{"filtered":{}},"size":48}"
    Then we get list with +1 items

  @auth
  Scenario: Deleting a Search Provider isn't allowed after articles have been fetched from this search provider
    Given "vocabularies"
        """
        [{"_id" : "crop_sizes",
            "display_name" : "Image Crop Sizes",
            "items" : [
                {
                    "width" : 800,
                    "is_active" : true,
                    "height" : 600,
                    "name" : "4-3"
                },
                {
                    "width" : 1280,
                    "is_active" : true,
                    "height" : 720,
                    "name" : "16-9"
                }
            ],
            "unique_field" : "name",
            "schema" : {
                "name" : {
                    "required" : true,
                    "type" : "string"
                },
                "height" : {
                    "type" : "integer"
                },
                "width" : {
                    "type" : "integer"
                }
            }
        }]
        """
    Given "search_providers"
	    """
        [{"search_provider": "aapmm", "source": "aapmm", "config": {"password":"", "username":""}}]
	    """
    And "desks"
        """
        [{"name": "Sports"}]
        """
    When we post to "search_providers_proxy?repo=#search_providers._id#"
        """
        {"guid": "20150329001116807745", "desk": "#desks._id#"}
        """
    Then we get response code 201
    When we delete "search_providers/#search_providers._id#"
    Then we get error 403
        """
        {"_status": "ERR", "_message": "Deleting a Search Provider after receiving items is prohibited."}
        """

  @auth @test
  Scenario: Can get item from external source to a specific desk and stage
    Given "search_providers"
	    """
        [{"search_provider": "aapmm", "source": "aapmm", "config": {"password":"", "username":""}}]
	    """
    And "desks"
        """
        [{"name": "Sports"}]
        """
    And "stages"
        """
        [{"name": "schedule", "desk": "#desks._id#"}]
        """
    When we post to "search_providers_proxy?repo=#search_providers._id#"
        """
        {"guid": "20150329001116807745", "desk": "#desks._id#", "stage": "#stages._id#"}
        """
    Then we get OK response
    When we get "archive/#search_providers_proxy._id#"
    Then we get existing resource
        """
        {"family_id": "20150329001116807745", "task" : {"desk": "#desks._id#", "stage": "#stages._id#"}}
        """

