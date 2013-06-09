package com.sith.event;

import com.sith.SithAPI;
import com.sith.perception.Perception;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EventHandler{
	HTTPUtil httpUtil=new HTTPUtil();


	public boolean addEvent(String eventID, String eventName,String eventAdmin, String startTime, String endTime, String date, String location, String description, String perceptionSchema){
		Map<String,String> parms=new HashMap<String,String>();
		parms.put("eventID",eventID);
		parms.put("eventName",eventName);
		parms.put("eventAdmin",eventAdmin);
		parms.put("desc",description);
		parms.put("location",location);
		parms.put("date",date);
		parms.put("startTime",startTime);
		parms.put("endTime",endTime);
		parms.put("perceptionSchema",perceptionSchema);

		String result=null;
		try{
			result=httpUtil.doPost(SithAPI.ADD_EVENT,parms);
			if(!result.equals("")){
				if("{\"response\":true}".equals(result)){
					return true;
				}
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}

		return false;
	}

	public boolean addUserToEvent(String userID,String eventID){

		String result=null;
		try{
			result=httpUtil.doGet(SithAPI.ADD_USER_TO_EVENT+"?eventID="+eventID+"&userID="+userID+"&status=participant");
			if(!result.equals("")){
				if("{\"result\":true}".equals(result)){
					return true;
				}
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	public boolean addComment(String eventID, String userID,String perceptionValue, String text){
		Map<String,String> parms=new HashMap<String,String>();
		parms.put("eventID",eventID);
		parms.put("userID",userID);
		parms.put("perceptionValue",perceptionValue);
		parms.put("text",text);

		String result=null;
		try{
			result=httpUtil.doPost(SithAPI.PUBLISH_COMMENT,parms);
			System.out.println(result);
			if(!result.equals("")){
				if("{\"response\":true}".equals(result)){
					return true;
				}
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}

		return false;
	}

	public boolean isEventAvailable(String eventID){
		//Check availability via API
		return true;
	}

	public Event getEvent(String eventID){
		Event event=null;

		String result=null;
		try{
			result=httpUtil.doGet(SithAPI.GET_EVENT_BY_ID+"?eventID="+eventID);
			JSONObject jsonObject=new JSONObject(result.substring(1,result.length()-1));
			event= new Event(jsonObject.getString("eventID"),jsonObject.getString("eventName"),jsonObject.getString("eventAdmin"),jsonObject.getString("description"),jsonObject.getString("startTime"),jsonObject.getString("endTime"),jsonObject.getString("date"),jsonObject.getString("location"),jsonObject.getString("perceptionSchema"));
			return event;
		}catch(Exception e){
			e.printStackTrace();
		}
		return event;

	}

	public ArrayList<Perception> getComments(String eventID){
		ArrayList<Perception> comments=null;

		String result=null;
		try{
			result=httpUtil.doGet(SithAPI.GET_ALL_COMMENTS+"?eventID="+eventID);
			JSONArray jsonArray=new JSONArray(result);
			comments=new ArrayList<Perception>();
			for(int i=0;i<jsonArray.length();i++){
				JSONObject jsonObject=jsonArray.getJSONObject(i);
				Perception perception= new Perception(jsonObject.getString("userID"),jsonObject.getString("eventID"),jsonObject.getString("perceptionValue"),jsonObject.getString("text"));
				comments.add(perception);
			}return comments;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;


	}

	public Participant getParticipant(String name){
		if(name.equals("aslg")){
			return new Participant("aslg","2.35PM","Happy");
		}
		else{
			return new Participant("andunslg","2.35PM","Happy");
		}
	}

	public List<Participant> getParticipants(String eventID){
		ArrayList<Participant> participants=new ArrayList<Participant>();

		participants.add(new Participant("Prabhath Pathirana","2.35PM","Happy"));
		participants.add(new Participant("aslg","2.35PM","Happy"));
		return participants;
	}

}
