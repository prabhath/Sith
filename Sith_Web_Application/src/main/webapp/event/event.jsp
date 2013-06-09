<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<!DOCTYPE html>
<html lang="">

<%
    EventHandler eventHandler=new EventHandler();
    Event currentEvent=null;

    if(request.getParameter("eventID")!=null){
        currentEvent=eventHandler.getEvent(request.getParameter("eventID").toString());
        session.setAttribute("eventID",currentEvent.getEventID());
    }else{
        currentEvent=eventHandler.getEvent(session.getAttribute("eventID").toString());
    }
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());
    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }
%>

<head>
    <meta charset="utf-8">
    <title>SITH Dashboard</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="../css/style.css" media="all"/>
    <link rel="stylesheet" href="../css/bootstrap-responsive.css" media="all"/>
    <link rel="stylesheet" type="text/css" href="../css/carousel.css" media="screen" alt="">
    <link rel="stylesheet" type="text/css" href="../css/tooltipster.css"/>

    <script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.carousel.min.js"></script>
    <script type="text/javascript" src="../js/jquery.mousewheel.js"></script>
    <script src="../js/jquery-ui.js"></script>
    <script type="text/javascript" src="../js/jquery.tooltipster.min.js"></script>

    <script src="../js/jquery.wysiwyg.js"></script>
    <script src="../js/custom.js"></script>
    <script src="../js/cycle.js"></script>
    <script src="../js/jquery.checkbox.min.js"></script>
    <script src="../js/flot.js"></script>
    <script src="../js/flot.resize.js"></script>
    <script src="../js/flot-graphs.js"></script>
    <script src="../js/flot-time.js"></script>
    <script src="../js/cycle.js"></script>
    <script src="../js/jquery.tablesorter.min.js"></script>

    <script type="text/javascript">

        function postToAPI(eventID, userID, perceptionValue) {
            $.ajax({
                url: 'http://192.248.8.246:3000/publishEventPerception',
                data: 'eventID=' + eventID + '&userID=' + userID + '&perceptionValue=' + perceptionValue,
                type: 'POST',
                success: function (data) {
                    console.log('Success: ')
                },
                error: function (xhr, status, error) {
                    console.log('Error: ' + error.message);
                }
            });
        }

        $(document).ready(function () {
            $('.thumbnail').tooltipster();
        });


    </script>
</head>
<body>

<div class="testing">
    <header class="main">
        <h1><strong>Sith </strong>Dashboard</h1>
        <input type="text" value="search"/>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/uiface2.jpeg" alt="" height="40" width="40"/> Welcome
                back <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
                Guest <%}%></p>
        </div>
        <div class="buttons">
            <button class="ico-font">&#9206;</button>
		<span class="button dropdown">
			<a href="#">Notifications <span class="pip"></span></a>
			<ul class="notice">
                <li>
                    <hgroup>
                        <h1>You have no notifications</h1>
                    </hgroup>
                </li>
            </ul>
		</span>
            <span class="button"><a href="../home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button"><a href="../index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
        <li>
            <a href="../home.jsp"><span class="icon" style="font-size: 40px">&#9790;&thinsp;</span>Home</a>
        </li>
        <li>
            <a href="event.jsp"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>My Perception</a>
        </li>
        <li>
            <a href="#"><span class="icon">&#128711;</span>Analytics</a>
            <ul class="submenu">
                <li><a href="realTimeAnalytics.jsp"></span>Realtime Analytics</a></li>
                <li><a href="nonRealTimeAnalytics.jsp"></span>Non Realtime Analytics</a></li>
            </ul>
        </li>
        <li>
            <a href="questions.jsp"><span class="icon">&#59160;</span>Questions</a>
        </li>
        <li>
            <a href="participants.jsp"><span class="icon">&#128101;</span>Participants</a>
        </li>
        <%
            if(currentEvent.getAdminID().equals(participant.getUserID())){
        %>
        <li>
            <a href="eventAdmin.jsp"><span class="icon">&#128100;</span>Event Admin</a>
        </li>
        <%
            }
        %>

    </ul>
</nav>

<section class="alert">
    <div class="green">
        <p>Current event is <%=currentEvent.getEventName()%> , Click here to <a href="../myEvents.jsp">change</a></p>
    </div>
</section>


<section class="content" height="250">

    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>My Perceptions</h1>

                <h2>Current Perception</h2>
            </hgroup>
        </header>
        <h4 id="h42" align="center">Select your Perception</h4>

        <div id="wrapper2" style="width:100%; text-align:center;visibility:hidden">
            <img id="selected_image2" src="../images/perceptions/default.png" alt="Smiley face" align="center">
        </div>
        <div class="row-fluid" align="center">
            <%
                String perceptionArr[]=currentEvent.getPerceptionSchema().split(":");
                for(int i=0;i<perceptionArr.length;i++){
                    String perception=perceptionArr[i];
                    String lowerPerception=perception.toLowerCase();
                    System.out.println(lowerPerception);
            %>
            <div id="<%=lowerPerception%>" class="perception">
                <img class="thumbnail" style="width: 80px;height: 80px" src="<%="../images/perceptions/"+lowerPerception+".png"%>"
                     title="<%=perception%>">
            </div>

            <%
                }
            %>

        </div>
    </section>


</section>
<script>

    $("#awesome").click(function () {
        $("#awesome").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Awesome";
        edit_save.src = "../images/perceptions/awesome.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Awesome");
    });

    $("#wonderful").click(function () {
        $("#wonderful").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Wonderful";
        edit_save.src = "../images/perceptions/wonderful.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Wonderful");
    });

    $("#excited").click(function () {
        $("#excited").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Excited";
        edit_save.src = "../images/perceptions/excited.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Excited");
    });

    $("#happy").click(function () {
        $("#happy").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Happy";
        edit_save.src = "../images/perceptions/happy.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>',' <%=session.getAttribute("user").toString()%>', "Happy");
    });

    $("#interested").click(function () {
        $("#interested").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Interested";
        edit_save.src = "../images/perceptions/interested.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Interested");
    });

    $("#neutral").click(function () {
        $("#neutral").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Neutral";
        edit_save.src = "../images/perceptions/neutral.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Neutral");
    });

    $("#bored").click(function () {
        $("#bored").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Bored";
        edit_save.src = "../images/perceptions/bored.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Bored");
    });

    $("#sleepy").click(function () {
        $("#sleepy").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Sleepy";
        edit_save.src = "../images/perceptions/sleepy.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>',' <%=session.getAttribute("user").toString()%>', "Sleepy");
    });

    $("#sad").click(function () {
        $("#sad").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Sad";
        edit_save.src = "../images/perceptions/sad.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Sad");
    });
    $("#angry").click(function () {
        $("#angry").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Angry";
        edit_save.src = "../images/perceptions/angry.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>',' <%=session.getAttribute("user").toString()%>', "Angry");
    });
    $("#disgusting").click(function () {
        $("#disgusting").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Disgusting";
        edit_save.src = "../images/perceptions/disgusting.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Disgusting");
    });
    $("#horrible").click(function () {
        $("#horrible").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Horrible";
        edit_save.src = "../images/perceptions/horrible.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Horrible");
    });


</script>

</body>
</html>