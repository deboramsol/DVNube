public with sharing class Contacts {
    public static List<Contact> createMembers(String firstName, String lastName ) {
        List<Contact> members = new List<Contact>();
        List<String> families =  getFamilies(lastName);
        List<Account> familyAcc = [SELECT Id, Name FROM Account WHERE  Name IN :families];
        
        for(Account family: familyAcc){
            Contact member = new Contact (firstName= firstName, lastName= lastName, AccountId = family.Id);
            members.add(member);
        }        
        return members;
    }
    
    public static List<String> getFamilies(String lastName) {
        List<String> families = new List<String>();
        List<String> lastNames = lastName.split(' ');
        Integer lastNamesQuantity = lastNames.size();
        
        for (Integer i = 0; i < lastNamesQuantity; i++) {
            families.addAll(buildLastNames(lastNames, lastNamesQuantity, i));
        }
        
        return families;
    }
    
    private static List<String> buildLastNames(List<String> lastNames, Integer lastNamesQuantity, Integer startingIndex) {
        List<String> lastNameTemp = new List<String>();
        String currentLastName = '';
        for (Integer j = startingIndex; j < lastNamesQuantity; j++) {
            if (j > startingIndex) {
                currentLastName += ' ';
            }
            currentLastName += lastNames[j];
            lastNameTemp.add(currentLastName);
        }
        return lastNameTemp;
    }
}