---
title: Perform CRUD Operations using `Xrm.WebApi`
date: 2019-09-18 00:00:00 +0000
categories: [Tips and Tricks, Dynamics 365]
tags: [javascript, dynamics 365, examples, crud, webapi]
seo:
  date_modified: 2020-03-17 00:40:12 +0000
---

I have recently had a challenge where I needed to perform some CRUD operations on a bunch of records, and wondered whether I could use the Client API `Xrm.WebApi.online.executeMultiple` to achieve this.

While there are helper methods to perform CRUD operations on a single record, there were no examples of this in the PowerApps documentation, so I decided to add my own in [PR#626](https://github.com/MicrosoftDocs/powerapps-docs/pull/626) (any comments/improvements appreciated!).

Here are the examples I've come up with, hope this saves someone some time!:

> Update: These examples are now in the PowerApps docs, check it out: [Perform CRUD Operations](https://docs.microsoft.com/en-us/powerapps/developer/model-driven-apps/clientapi/reference/xrm-webapi/online/execute#perform-crud-operations).

#### Create a record

```js
var Sdk = window.Sdk || {};
/**
 * Request to execute a create operation
 */
Sdk.CreateRequest = function (entityName, payload) {
    this.etn = entityName;
    this.payload = payload;
    this.getMetadata = function () {
        return {
            boundParameter: null,
            parameterTypes: {},
            operationType: 2, // This is a CRUD operation. Use '0' for actions and '1' for functions
            operationName: "Create",
        };
    };
};
// Construct a request object from the metadata
var payload = {
    name: "Fabrikam Inc."
};
var createRequest = new Sdk.CreateRequest("account", payload);
// Use the request object to execute the function
Xrm.WebApi.online.execute(createRequest).then(
    function (result) {
        if (result.ok) {
            console.log("Status: %s %s", result.status, result.statusText);
            // perform other operations as required;
        }
    },
    function (error) {
        console.log(error.message);
        // handle error conditions
    }
);
 ```

#### Retrieve a record

The following example demonstrates how to perform a Retrieve operation.

```js
var Sdk = window.Sdk || {};
/**
 * Request to execute a retrieve operation
 */
Sdk.RetrieveRequest = function (entityReference, columns) {
    this.entityReference = entityReference;
    this.columns = columns;
    this.getMetadata = function () {
        return {
            boundParameter: null,
            parameterTypes: {},
            operationType: 2, // This is a CRUD operation. Use '0' for actions and '1' for functions
            operationName: "Retrieve",
        };
    };
};
// Construct request object from the metadata
var entityReference = {
    entityType: "account",
    id: "0b9b8a43-e0dd-e911-a849-000d3a11e59b"
};
var retrieveRequest = new Sdk.RetrieveRequest(entityReference, ["name"]);
// Use the request object to execute the function
Xrm.WebApi.online.execute(retrieveRequest).then(
    function (result) {
        if (result.ok) {
            console.log("Status: %s %s", result.status, result.statusText);
            result.json().then(
                function (response) {
                    console.log("Name: %s", response.name);
                    // perform other operations as required;
                });
        }
    },
    function (error) {
        console.log(error.message);
        // handle error conditions
    }
);
```

#### Update a record

The following example demonstrates how to perform a Update operation.

```js
var Sdk = window.Sdk || {};
/**
 * Request to execute an update operation
 */
Sdk.UpdateRequest = function (entityName, entityId, payload) {
    this.etn = entityName;
    this.id = entityId;
    this.payload = payload;
    this.getMetadata = function () {
        return {
            boundParameter: null,
            parameterTypes: {},
            operationType: 2, // This is a CRUD operation. Use '0' for actions and '1' for functions
            operationName: "Update",
        };
    };
};
// Construct a request object from the metadata
var payload = {
    name: "Updated Sample Account"
};
var updateRequest = new Sdk.UpdateRequest("account", "0b9b8a43-e0dd-e911-a849-000d3a11e59b", payload);
// Use the request object to execute the function
Xrm.WebApi.online.execute(updateRequest).then(
    function (result) {
        if (result.ok) {
            console.log("Status: %s %s", result.status, result.statusText);
            // perform other operations as required;
        }
    },
    function (error) {
        console.log(error.message);
        // handle error conditions
    }
);
```

#### Delete a record

The following example demonstrates how to perform a Delete operation.

```js
var Sdk = window.Sdk || {};
/**
 * Request to execute a delete operation
 */
Sdk.DeleteRequest = function (entityReference) {
    this.entityReference = entityReference;
    this.getMetadata = function () {
        return {
            boundParameter: null,
            parameterTypes: {},
            operationType: 2, // This is a CRUD operation. Use '0' for actions and '1' for functions
            operationName: "Delete",
        };
    };
};
// Construct request object from the metadata
var entityReference = {
    entityType: "account",
    id: "0b9b8a43-e0dd-e911-a849-000d3a11e59b"
};
var deleteRequest = new Sdk.DeleteRequest(entityReference);
// Use the request object to execute the function
Xrm.WebApi.online.execute(deleteRequest).then(
    function (result) {
        if (result.ok) {
            console.log("Status: %s %s", result.status, result.statusText);
            // perform other operations as required;
        }
    },
    function (error) {
        console.log(error.message);
        // handle error conditions
    }
);
```
