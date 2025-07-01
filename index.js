const express = require('express');
const AWS = require('aws-sdk');
const app = express();
const port = process.env.PORT || 3001;

// Set region for CloudWatch
AWS.config.update({ region: 'us-east-1' });

const cloudwatch = new AWS.CloudWatch();

// Root route with CloudWatch metric publishing
app.get('/', async (req, res) => {
  // Publish a custom metric to CloudWatch
  const params = {
    MetricData: [
      {
        MetricName: 'RequestsPerMinute',
        Dimensions: [
          {
            Name: 'ServiceName',
            Value: 'NodeApp'
          }
        ],
        Unit: 'Count',
        Value: 1
      }
    ],
    Namespace: 'Custom/Metrics'
  };

  // Send metric to CloudWatch
  cloudwatch.putMetricData(params, function (err, data) {
    if (err) {
      console.error('CloudWatch metric error:', err);
    } else {
      console.log('Published metric to CloudWatch');
    }
  });

  res.send('Hello, welcome to my site!!');
});

// Start server
app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});
