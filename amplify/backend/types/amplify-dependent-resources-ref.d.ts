export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "Booking": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string"
        }
    },
    "storage": {
        "s3bookingstorage5ff514c1": {
            "BucketName": "string",
            "Region": "string"
        }
    },
    "api": {
        "Booking": {
            "GraphQLAPIKeyOutput": "string",
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        }
    }
}