<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.event.Event" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.user.UserHandler" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="">

<%
    SithAPI sithAPI=SithAPI.getInstance();


    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }
    EventHandler eventHandler=new EventHandler();
    UserHandler userHandler= new UserHandler();
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());

    ArrayList<Event> temp=sithAPI.getEventList();
    ArrayList<Event> events=new ArrayList<Event>();

    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
    DateFormat dateFormat1 = new SimpleDateFormat("MM/dd/yyyy HH:mm");
    Date currentDate = new Date();

    for(Event event:temp){
        Date eventEndDate=dateFormat1.parse(event.getEndDate()+" "+event.getEndTime());
        if(currentDate.compareTo(eventEndDate)<0){
            events.add(event);
        }
    }

    ArrayList<Event> userEvents=userHandler.getUserEventList(participant.getUserID());
    ArrayList<String>  userEventsIDs= new ArrayList<String>();
    for(Event event:userEvents){
        userEventsIDs.add(event.getEventID());
    }

%>

<head>
    <meta charset="utf-8">
    <title>SITH Dashboard</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all"/>
    <link rel="stylesheet" href="css/bootstrap-responsive.css" media="all"/>
    <link rel="stylesheet" href="css/apprise.min.css" type="text/css" />


    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script src="js/jquery.wysiwyg.js"></script>
    <script src="js/custom.js"></script>
    <script src="js/cycle.js"></script>
    <script src="js/jquery.checkbox.min.js"></script>
    <script src="js/flot.js"></script>
    <script src="js/flot.resize.js"></script>
    <script src="js/flot-graphs.js"></script>
    <script src="js/flot-time.js"></script>
    <script src="js/cycle.js"></script>
    <script src="js/jquery.tablesorter.min.js"></script>
    <script src="js/apprise-1.5.min.js"></script>


    <script type="text/javascript">

        $(document).ready(function () {

        });


    </script>
</head>
<body>

<div class="testing">
    <header class="main">
        <h1><strong>Sith </strong>Dashboard</h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/> Welcome
                back <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
                Guest <%}%></p>
        </div>
        <div class="buttons">
            <button class="ico-font">&#9206;</button>
		<%--<span class="button dropdown">--%>
			<%--<a href="#">Notifications <span class="pip"></span></a>--%>
			<%--<ul class="notice">--%>
                <%--<li>--%>
                    <%--<hgroup>--%>
                        <%--<h1>You have no notifications</h1>--%>
                    <%--</hgroup>--%>
                <%--</li>--%>
            <%--</ul>--%>
		<%--</span>--%>
            <span class="button"><a href="home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>

<nav>
    <ul>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span>Events</a>
            <ul class="submenu">
                <li><a href="myEvents.jsp"></span>My Events</a></li>
                <li><a href="joinEvents.jsp"></span>Join Events</a></li>
                <li><a href="addEvents.jsp"></span>Add Events</a></li>
            </ul>
        </li>
        <li>
            <a href="profile.jsp"><span class="icon">&#128101;</span>Profile</a>
        </li>
    </ul>
</nav>


<section class="content" style="margin-top: 10px">

    <section class="widget">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Available Events</h1>

                <h2>Click to register</h2>
            </hgroup>

        </header>

            <div class="content">

                <table id="myTable" border="0" width="100">
                    <thead>
                    <tr>
                        <th class="avatar">Name</th>
                        <th>Description</th>
                        <th>Duration</th>
                        <th>Location</th>
                        <th></th>

                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for(Event event : events){
                            if(event.getAdminID().equals(participant.getUserID())||userEventsIDs.contains(event.getEventID())){
                                continue;
                            }
                    %>
                    <tr class="event_rows">
                        <td class="avatar"><%=event.getEventName()%>
                        </td>
                        <td><%=event.getDescription()%>
                        </td>
                        <td><%=event.getStartDate()+" "+event.getStartTime()+" to "+event.getEndDate()+" "+event.getEndTime()%>
                        </td>
                        <td><%=event.getLocation()%>
                        </td>
                        <td >
                            <span id="<%=event.getEventID()%>" class="button" ><a>Join</a></span>
                        </td>

                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>


    </section>

</section>
<script type="text/javascript">
    $('.button').click(function () {

        var datObj = {};
        var id = this.id;
        datObj['eventID'] = id;
        datObj['userID']  = '<%=participant.getUserID()%>';

        $.ajax({
            url: 'event/addUserToEventHandler.jsp',
            data: datObj,
            type: 'POST',
            success: function (data) {
                var $response = $(data);
                var msg = $response.filter('#msg').text();
                apprise(msg)
                if (msg == "You are successfully registered to event\n") {
                    window.location.href = 'event/event.jsp' + '?eventID=' + id;
                }
            },
            error: function (xhr, status, error) {
                apprise("Error joining event - " + error.message);
            }
        });
    });
</script>

</body>
</html>