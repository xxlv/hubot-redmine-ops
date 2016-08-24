class Redmine

    constructor:(host,header)->
        @host=host
        @auth_header=header||[]

    listIssues:(pid,cb)->
        limit=1000
        api="#{@host}/issues.json?project_id=#{pid}&key=#{PM_KEY}"
        api=api.concat "&limit=#{limit}"
        api=api.concat "&assigned_to_id=me"
        api=api.concat "&sort=due_date:desc"

        @get api,cb

    updateIssue:(id,data,cb)->
        api="#{@host}/issues/#{id}.json?key=#{PM_KEY}"
        @put api,data,cb



    get:(api,cb)->
        @request 'GET',api,[],cb


    put:(api,data,cb)->
        @request "PUT",api,data,cb

    request:(method,url,data,cb) ->
        if typeof data isnt "string"
            data=JSON.stringify data

        req_body=
            method:method
            uri:url
            headers:
                'content-type':'application/json'
            body:data

        request req_body,(err,req,body) ->
            cb err,body
