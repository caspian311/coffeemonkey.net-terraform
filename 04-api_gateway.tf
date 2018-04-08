resource "aws_api_gateway_rest_api" "api" {
  name = "coffeemonkey"
}

module "api_endpoint" {
  source = "./modules/api"

  root_resource_id = "${aws_api_gateway_rest_api.api.root_resource_id}"
  api_id = "${aws_api_gateway_rest_api.api.id}"
  path_part = "movies"
  method = "GET"
  lambda_arn = "${aws_lambda_function.lambda.arn}"

  myregion = "${var.myregion}"
  accountId = "${var.accountId}"
}

resource "aws_lambda_function" "lambda" {
  filename         = "lambda.zip"
  function_name    = "mylambda"
  role             = "${aws_iam_role.role.arn}"
  handler          = "index.lambda_handler"
  runtime          = "python2.7"
  source_code_hash = "${base64sha256(file("lambda.zip"))}"
}


resource "aws_iam_role" "role" {
  name = "myrole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


