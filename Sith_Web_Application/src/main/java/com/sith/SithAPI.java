package com.sith;

import com.sith.event.Event;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;

public class SithAPI{
	public static SithAPI sithAPI=new SithAPI();
	private HTTPUtil httpUtil=new HTTPUtil();

	public static String NODEAPI="http://192.248.8.246:3000/";

	public static String LOGIN=NODEAPI+"authenticateUser";
	public static String SIGNUP=NODEAPI+"registerAnnonymousUser";

	public static String GET_EVENT_LIST=NODEAPI+"getAllEvents";
	public static String ADD_EVENT=NODEAPI+"addEvent";
	public static String ADD_USER_TO_EVENT=NODEAPI+"registerUserForEvent";
	public static String REMOVE_USER_FROM_EVENT=NODEAPI+"unsubscribeFromEvent" ;
	public static String GET_EVENT_BY_ID=NODEAPI+"getEventById";
	public static String PUBLISH_COMMENT=NODEAPI+"publishComment";
	public static String GET_EVENT_COMMENTS=NODEAPI+"getEventComments";
	public static String GET_PARTICIPANTS=NODEAPI+"getParticipants";
	public static String DELETE_EVENT=NODEAPI+"deleteEvent";
	public static String UPDATE_EVENT=NODEAPI+"updateEvent";
	public static String SET_COMMENT_ENABLED=NODEAPI+"setCommentEnabled";


	public static String GET_MASTER_PERCEPTIONS=NODEAPI+"getMasterPerceptions";

    public static String GET_USER_BY_ID=NODEAPI+"getUserById";
    public static String GET_USER_EVENT_LIST=NODEAPI+"getSubscribedEvents";
	public static String UPDATE_USER=NODEAPI+"updateAnnonymousUser";
	public static String DELETE_USER=NODEAPI+"deleteUser";


	private ArrayList<String> masterPerceptionCollection;
	private HashMap<String,Integer>  masterPerceptionCollectionMap;

	public ArrayList<Event> getEventList(){
		ArrayList<Event> events=null;

		String result=null;
		try{
			result=httpUtil.doGet(GET_EVENT_LIST);
			JSONArray jsonArray=new JSONArray(result);
			events=new ArrayList<Event>();
			for(int i=0;i<jsonArray.length();i++){
				JSONObject jsonObject=jsonArray.getJSONObject(i);
				Event event= new Event(jsonObject.getString("eventID"),jsonObject.getString("eventName"),jsonObject.getString("eventAdmin"),jsonObject.getString("description"),jsonObject.getString("startDate"),jsonObject.getString("endDate"),jsonObject.getString("startTime"),jsonObject.getString("endTime"),jsonObject.getString("location"),jsonObject.getString("perceptionSchema"),jsonObject.getString("commentEnabled"),jsonObject.getString("colors"));
				events.add(event);
			}

		}catch(Exception e){
			e.printStackTrace();
		}

		return events;
	}

	public ArrayList<String> getMasterPerceptions(){

		try{
			String result=httpUtil.doGet(GET_MASTER_PERCEPTIONS);
			JSONArray jsonArray=new JSONArray(result);
			if(jsonArray!=null){
				masterPerceptionCollection=new ArrayList<String>();
				masterPerceptionCollectionMap=new HashMap<String,Integer>();

				for(int i=0;i<jsonArray.length();i++){
					JSONObject jsonObject=jsonArray.getJSONObject(i);
					masterPerceptionCollection.add(jsonObject.getString("perception"));
					masterPerceptionCollectionMap.put(jsonObject.getString("perception"),Integer.parseInt(jsonObject.getString("value")));
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return masterPerceptionCollection;
	}

	public HashMap<String,Integer> getMasterPerceptionsMap(){
		this.getMasterPerceptions();
		return masterPerceptionCollectionMap;
	}


	public static SithAPI getInstance(){
		return sithAPI;
	}


}
