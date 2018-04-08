resource "aws_api_gateway_rest_api" "api" {
  name = "coffeemonkey"
}

module "movies-endpoint" {
  source = "./modules/api"

  root_resource_id = "${aws_api_gateway_rest_api.api.root_resource_id}"
  api_id = "${aws_api_gateway_rest_api.api.id}"
  path_part = "movies"
  method = "GET"
  lambda_arn = "${aws_lambda_function.movies-lambda.arn}"

  myregion = "${var.myregion}"
  accountId = "${var.accountId}"
}

module "login-endpoint" {
  source = "./modules/api"

  root_resource_id = "${aws_api_gateway_rest_api.api.root_resource_id}"
  api_id = "${aws_api_gateway_rest_api.api.id}"
  path_part = "login"
  method = "POST"
  lambda_arn = "${aws_lambda_function.login-lambda.arn}"

  myregion = "${var.myregion}"
  accountId = "${var.accountId}"
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name = "dev"
}

resource "aws_api_gateway_stage" "stage" {
  stage_name = "prod"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  deployment_id = "${aws_api_gateway_deployment.deployment.id}"
}


resource "aws_lambda_function" "movies-lambda" {
  filename         = "lambda.zip"
  function_name    = "movies"
  role             = "${aws_iam_role.lambda-role.arn}"
  handler          = "movies.lambda_handler"
  runtime          = "python2.7"
  source_code_hash = "${base64sha256(file("lambda.zip"))}"
}

resource "aws_lambda_function" "login-lambda" {
  filename         = "lambda.zip"
  function_name    = "login"
  role             = "${aws_iam_role.lambda-role.arn}"
  handler          = "login.lambda_handler"
  runtime          = "python2.7"
  source_code_hash = "${base64sha256(file("lambda.zip"))}"
}


resource "aws_iam_role" "lambda-role" {
  name = "lambda-role"

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


