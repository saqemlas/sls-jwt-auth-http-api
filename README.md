# JWT Auth Http Api Gateway

## Info 

This handles deployment for a http api gateway with an integrated lambda and jwt authorizer. 

Http Apis are designed for low-latency and cost-effective integrations, some benefits included in this deploment are:
- built in JWT authorization
- support catch-all routing (which is not possible with Rest Apis)
- global rules for CORS headers
- trigger AWS Lambda

You can use JSON Web Tokens (JWTs) as a part of OpenID Connect (OIDC) and OAuth 2.0 frameworks to restrict client access to your APIs. If you configure a JWT authorizer for a route of your API, API Gateway validates the JWTs that clients submit with API requests. API Gateway allows or denies requests based on token validation, and optionally, scopes in the token. If you configure scopes for a route, the token must include at least one of the route's scopes. You can configure distinct authorizers for each route of an API, or use the same authorizer for multiple routes.

For more information...
- [Serverless Framework: Http Support](https://www.serverless.com/blog/aws-http-api-support)
- [Serverless Framework: Http Lambda Events](https://www.serverless.com/framework/docs/providers/aws/events/http-api)
- [AWS Documentation: Http vs Rest](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-vs-rest.html)
- [AWS Documentation: Http Api Jwt Authorizer ](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-jwt-authorizer.html)
- [AWS Documentation: Custom Scopes in Amazon Cognito for Api Gateway](https://aws.amazon.com/premiumsupport/knowledge-center/cognito-custom-scopes-api-gateway/)
- [AWS Documentation: Defining Resource Servers for User Pools](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-define-resource-servers.html)


## Architecture

<p align="center">
  <img src="/architecture-diagram.drawio.svg" />
</p>


## Usage 

### Credentials:
```bash
export AWS_PROFILE=<profile_name>
```

### Install Dependencies:

```bash
yarn run install
```

### Deploy:

```bash
yarn run deploy
```

### Invoke Locally:

```bash
yarn run invoke <function-name>
```

### Test Deployed Api:

```bash
bash test-auth.sh
```

### Remove:

```bash
yarn run remove
```
