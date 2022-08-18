# This repository contains: 



1. A To do list Flutter application with checkbox features, where the user can add some task and check when it has been completed. The application sort all tasks showing the unchecked ones first and checked ones last. 



# This project uses the following external packages:



1. **path_provider: ^2.0.11**: used to persist data when the application is closed and reopened. 





# This project uses the following external API's:



1. Do not use, only uses data produced by the application itself.



# The lib's repository is organized as follows:



- **pages:** repo that contains inside the file home.dart.

1. home.dart: contains inside the widget that build the home page
   1. Home ( ): a StatefulWidget that build the home page. 


- **main.dart:** file that runs the application

1. void main(): 
2. Class MyApp
   1. MaterialApp
      1. Home( )



# This project contains the following pages:



Number of pages: 1

1. Home. all the dynamics of the application happens inside home





# The user needs to enter the following data:



On the home page:

1. Texts with task descriptions to be added to the task list. 
2. A check click to signal when a task is complete. 





# This project contains the following controllers to capture the data entered by the user. 



Home page

1. todoController: capture the task text entered by the user and then input in a Task Model.





# This project contains the following models to receive the data entered by the user:





1. Map newToDo = {"**title**": "entered data added here" , "**ok**" : true or false}
   1. **title**: used to receive the entered description of a task
   2. **ok**: used to receive the status of completed task, that will be true when the task is completed and false when its not. 

2. Each "newToDo" will be added inside a list named  "todoList" that will store all the tasks added by the user.





# This project contains the following Lists to store all generated models:

1. todoList = [ 	{"**title**": "description task1" , "**ok**" : "true"}	 ,	{"**title**": "description task2" , "**ok**" : "false"}	 ]
2. todoList : each new task added by the user is received in a newToDo map model so then it will be stored inside todoList. Items within this list are rendered on the screen every time a new task is added.



This project contains the following Lists:



# This project persists data as follows:



1. **path_provider: ^2.0.11**: external package used to persist data when the application is closed and reopened.





# This project contains the following functions:



Void 


1. **addTask**:  add task into the todoList
2. **deleteTask:** located inside the Dismissible widget, this function delete the chosen task from the todoList
3. **undoTaskDeletion:** shows a snackbar with an undo delete button that when clicked re-adds the deleted task into the list. 



Futures - async

1. **Future < File >  getFile (.) async **: returns the path's file of the Application Documents Directory. Used to get  the path of the Application Documents Directory wich will be used to persist the application's data, that is, save data (write in file) when the app is closed and returns. (PERSIST DATA)  
2. **Future < File > saveData (.) async **: returns the file with the new saved data, that is, open the file and write a new data inside it. (PERSIST DATA)
3. **Future < String > readData( ) async**: returns the string that is saved inside file. This function is used within iniState to be decoded by json.decode and converted to Map Model of tasks that will be used in application. (PERSIST DATA)
4. **Future  _refresh ( ) async**: this function uses Future.delayed to delay the update of homepage in 0.5 seconds approximately. 

  

Widgets - returns

1. Widget **buildItem(context, index):** returns a widget that builds the visual for each task inside the toDoList. This widget is used inside ListView.builder





# This project contains the additional variables:



1. **lastRemovedTask:** saves the content of the task deleted by the user and uses this data later inside the undo deletion function
2. **indexRemovedTask:** saves the position's index of deleted task, so if the user decides to undo the action, the function returns the task in the same position it was in when it was deleted. 



# The Home page contains the following widget skeleton:

1. Scaffold 

   1. appBar:

   2. Body:

      1. Container

         1. padding

         2. **Collum**

            

            1. **Row**

               1. TextField

               2. ElevatedButton

                  

            2. **Expanded**

               1. **RefreshIndicator**
                  1. onRefresh
                     1. Future.delayed(Duration(milliseconds: 20000))
                     2. todoList.sort( )
                  2. **ListView.builder**
                     1. padding
                     2. ItemCount
                     3. itemBuilder: 
                        1. **buildItem**
                           1. **Dissmissible**
                              1. Key
                              2. background
                              3. direction
                              4. onDismissed
                                 1. deleteTask
                              5. Child
                                 1. **CheckBoxListTile**
                                    1. title
                                    2. value
                                    3. onChanged
                                    4. secondary
                                       1. CircleAvatar
                                          1. Icon
                                             1. Icons.chek or Icons.error

   

2. RefreshIndicator( ): used to refresh the order of tasks showing first not completed taskst and then the completed ones.

3. Dissmissble( ): was used to delete a task by slidable touch. 





# 
