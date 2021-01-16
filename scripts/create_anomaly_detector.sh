POST _opendistro/_anomaly_detection/detectors
{
  "name": "anomaly-test-detector",
  "description": "Anomaly Test detector",
  "time_field": "@timestamp",
  "indices": [
    "metricbeat*"
  ],
  "feature_attributes": [
    {
      "feature_name": "total_order",
      "feature_enabled": true,
      "aggregation_query": {
        "total_order": {
          "sum": {
            "field": "system.process.cpu.total.value"
          }
        }
      }
    }
  ],
  "filter_query": {
    "bool": {
      "filter": [
        {
          "exists": {
            "field": "system.process.cpu.total.value",
            "boost": 1
          }
        }
      ],
      "adjust_pure_negative": true,
      "boost": 1
    }
  },
  "detection_interval": {
    "period": {
      "interval": 1,
      "unit": "Minutes"
    }
  },
  "window_delay": {
    "period": {
      "interval": 1,
      "unit": "Minutes"
    }
  }
}
