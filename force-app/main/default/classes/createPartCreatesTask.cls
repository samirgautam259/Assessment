public class createPartCreatesTask 
{
    //Method to Insert part and create Task with active 'false'
    public static void forInsert( List<compliancequest__SQX_Part__c> parts)
    {
        //List for the task created
        List<Task> tasksCreated= new List<Task>();
        
        for(compliancequest__SQX_Part__c part : parts)
        {
            if(part.compliancequest__Active__c == false)
            {
                Task taskToCreate = new Task(
                    whatId = part.Id,
                    Subject = 'Review Part-'+ part.compliancequest__Part_Number__c,
                    OwnerId = part.OwnerId,
                    ActivityDate = Date.today() + 7,
                    Status = 'Not Started'); 
                tasksCreated.add(taskToCreate);
            }
        }
        
        //insert the task created in the List created above
        if(tasksCreated.size()>0)
        {
        insert tasksCreated;
        }
    }
    
    //Method to update the Task 'Completed' when active 'true' and reason for change have some value
    public static void forUpdate(List<compliancequest__SQX_Part__c> parts, Map<Id, compliancequest__SQX_Part__c> partMap )
    {
        
        //List of Task that are updated
        List<Task> tasksToUpdate= new List<Task>();
        Map <Id,compliancequest__SQX_Part__c> newPartMap = new Map<Id,compliancequest__SQX_Part__c>();
        Set<Id> partIds = new Set<Id>();
        //Filtering the Id of the active field from partMap
        for(compliancequest__SQX_Part__c part : partMap.values())
        {
            if(part.compliancequest__Active__c) 
            {
                partIds.add(part.Id);
            }
            
        }
       
        for(Task newtask : [SELECT Subject, ActivityDate, OwnerId, Status FROM Task Where WhatId IN :partIds])
        {   
            newtask.Status = 'Completed';
            tasksToUpdate.add(newtask);
        }
        if(tasksToUpdate.size()>0)
        {
        update tasksToUpdate;
        }
    }
}