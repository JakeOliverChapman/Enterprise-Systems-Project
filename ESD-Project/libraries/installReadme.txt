https://stackoverflow.com/questions/41332506/adding-gson-to-netbeans-java-project

gson-2.8.0.jar (classpath)
gson-2.8.0-sources.jar (sources)
gson-2.8.0-javadoc.jar (javadoc)
Then, you have to create a library on netbeans:

Right click on Libraries (inside the project in which you want to add Gson)
Properties
In categories: Libraries
Add Library (write a name, e.g.: Gson)
You have to import the right file in each of the tabs: classpath, sources, javadoc