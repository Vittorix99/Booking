const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "Booking": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://64pzsljrxngfhgvq4gcav4wquq.appsync-api.eu-central-1.amazonaws.com/graphql",
                    "region": "eu-central-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-amshgmm4c5euvhozqxmekchgfe"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-central-1:b68b7455-ff9b-40b0-a964-863f13f6a7bb",
                            "Region": "eu-central-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-central-1_QvImdMvOD",
                        "AppClientId": "18m3dheau9tcq2biqppgur4763",
                        "Region": "eu-central-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 6,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "booking-storage-5ff514c1101951-staging",
                        "Region": "eu-central-1"
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://64pzsljrxngfhgvq4gcav4wquq.appsync-api.eu-central-1.amazonaws.com/graphql",
                        "Region": "eu-central-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-amshgmm4c5euvhozqxmekchgfe",
                        "ClientDatabasePrefix": "Booking_API_KEY"
                    },
                    "Booking_AWS_IAM": {
                        "ApiUrl": "https://64pzsljrxngfhgvq4gcav4wquq.appsync-api.eu-central-1.amazonaws.com/graphql",
                        "Region": "eu-central-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "Booking_AWS_IAM"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "booking-storage-5ff514c1101951-staging",
                "region": "eu-central-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';