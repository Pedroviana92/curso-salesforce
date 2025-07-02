@isTest
global with sharing class TerceiraIntMock implements HttpCalloutMock {
    global HTTPResponse respond(HttpRequest req) {
        HttpResponse res = new HTTPResponse();
		String body = '{ "ExternalId" : "12345678910"}';

        res.setStatusCode(200);
        res.setHeader('Content-Type', 'application/json');
        res.setBody(body);
        return res;
    }
}