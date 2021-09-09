
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import router from "@/router";

function add_program(room_id,l,k=null)
    {
     if(l=="") return;
      console.log("Add program");
      const userId = FirebaseAuth.currentUser.uid;   
    let postData =  {
                        "program_name":l,
                        "program_xml":"",
                        "program_javascript":"",
                      };
     if(k!=null) postData=k;                 
     try
        {
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/programs`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      }
      catch (E)
      {
        console.error(E);
      }

      l="";
    }
    function add_camera (room_id,l,k=null){
     
      if(l=="") return;
      console.log("Add Camera");
     
      const userId = FirebaseAuth.currentUser.uid;
        
    let postData =  {
          "camera_name":l,
          "camera_url":""
          };
          if(k!=null) postData=k;   
        try{
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/cameras/`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      }
      catch (E)
      {
        console.error(E);
      }

    }
    function add_device(room_id,l,k=null)
    {
     
      if(l=="") return;
      console.log("Add Device");
      //const room_id=this.$route.params.rid;
      const userId = FirebaseAuth.currentUser.uid;
        
    let postData =  {
                                "device_name":l,
                                "mode":"relay",
                                "status":"0"
                      };
    if(k!=null) postData=k;
   try
      {
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/devices/`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      }
      catch (E)
      {
        console.error(E);
      }
    }
function start_run(room_id,team_name)
{     
      const userId = FirebaseAuth.currentUser.uid;
      let postData={};
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/devices/`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      
}
function stop_run(room_id,team_name)
{     
      const userId = FirebaseAuth.currentUser.uid;
      let postData={};
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/devices/`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      
}
function status_run(room_id)
{     
      const userId = FirebaseAuth.currentUser.uid;
      let postData={};
      let frooms= ref(FireDb, `/users/${userId}/rooms/${room_id}/pastruns`);
      let newroomref = push(frooms);
      set(newroomref,postData);
      
}        
   

export
{
    add_program,
    add_camera,
    add_device,
    start_run,
    status_run,
    stop_run
}