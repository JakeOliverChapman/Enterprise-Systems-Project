<html>
    <head>
        <link rel="stylesheet" href="primaryStyle.css">
        <title> Login Page </title>
    </head>

    <body>
        <div class="container">
            <div class="mainHeader" align="center">
                Register
            </div>
            <form class="formCenter" role="form" action="RegisterServlet" method="post">
                <input type="text" class="textField" name="fn" placeholder="First name">
                <br>
                <input type="text" class="textField" name="ln" placeholder="Last name">
                <br>
                <input type="text" class="textField" name="un" placeholder="Email address">
                <br>
                <input type="password" class="textField" name ="pw" placeholder="Password">
                <br>
                <input type="password" class="textField" name="pw1" placeholder="Confirm password">
                <br>
                <input  type="text" class="textField dateField" name="date" placeholder="Date of birth" onfocusin="(this.type='date')" onfocusout="(this.type='text')">
                <br><br>
                <button type="submit" class="submitButton"> Create account </button>
                <a class="submitButton" href="index.html"> Home </a>
            </form>
        </div>
    </body>
</html>
