request = require 'request'

class Redmine

    constructor:(host,pm_key) ->
        @host=host
        @pm_key=pm_key

    findIssue:(id,cb) ->
        api="#{@host}/issues/#{id}.json"

        @get api,cb

    createIssue:(issue,cb)->
        api="#{@host}/issues.json"

        @post api,issue,cb

    updateIssue:(id,issue,cb)->
        api="#{@host}/issues/#{id}.json"

        @put api,issue,cb

    deleteIssue:(id,cb)->
        api="#{@host}/issues/#{id}.json"

        @delete api,cb


    listIssues:(pid,cb) ->
        api="#{@host}/issues.json?project_id=#{pid}"

        @get api,cb


    get:(api,cb)->
        @request 'GET',api,[],cb

    post:(api,data,cb)->
        @request 'POST',api,data,cb

    put:(api,data,cb)->
        @request "PUT",api,data,cb

    delete:(api,cb)->
        @request 'DELETE',api,[],cb

    request:(method,url,data,cb) ->
        if typeof data isnt "string"
            data=JSON.stringify data

        req_body=
            method:method
            uri:url
            headers:
                'content-type':'application/json'
                "X-Redmine-API-Key": @pm_key

            body:data

        request req_body,(err,req,body) ->
            cb err,body



module.exports=Redmine
