trigger createPartTaskTrigger on compliancequest__SQX_Part__c (after insert, after update)
{
    if(trigger.isInsert )
    {
        createPartCreatesTask.forInsert(trigger.new);
    }
    if(trigger.isUpdate )
    {
        createPartCreatesTask.forUpdate(trigger.new,trigger.newMap);
    }
}