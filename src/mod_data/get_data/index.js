
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import router from "@/router";

function get_data_fromdb(k){
    const room_id=router.params.rid;
    const userId = FirebaseAuth.currentUser.uid;
    let b=[];
     onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/${k}`),(sn)=>
     {
       if(sn.exists())
       console.log(sn);
      sn.forEach((l)=>
     {
       b.push({
         data:l.val(),
         dev_id:l.key
       });
     })});
  return b;
  }
  function get_data_fromroomdb(room_id,k){
    const userId = FirebaseAuth.currentUser.uid;
    let b=[];
     onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/${k}`),(sn)=>
     {
       if(sn.exists())
       console.log(sn);
      sn.forEach((l)=>
     {
       b.push({
         data:l.val(),
         dev_id:l.key
       });
     })});
    return b;
  }

  function get_data_fromroomitemdb(room_id,k){
    const userId = FirebaseAuth.currentUser.uid;
    let b=null;
     onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/${k}`),(sn)=>
     {
       if(sn.exists())
       console.log(sn);
     
         b=sn.val();
         
      
    });
    return b;
  }

  function get_data_from_allroomdb(k){
    let room_id="";
   const userId = FirebaseAuth.currentUser.uid;
    let b=[];
onValue(ref(FireDb, `/users/${userId}/rooms`),(sn_out)=>{
      if(sn_out.exists()){
        sn_out.forEach((l)=>{
        room_id=l.key;
        //console.log(room_id);
       // console.log(`/users/${userId}/rooms/${room_id}/${k}`);
       onValue(ref(FireDb, `/users/${userId}/rooms/${room_id}/${k}`),(sna)=>{
           if(sna.exists())
              {
              //console.log(sna);
              sna.forEach((lb)=>{
                b.push(
                  {data:lb.val(),
                  room_id:room_id,
                  dev_id:lb.key});     
              });
              }
            });
        });

      }
    });

    return b;
}

function  get_rooms(){
    let l=[];
    const userId = FirebaseAuth.currentUser.uid;
    onValue(ref(FireDb, `/users/${userId}/rooms`),(sn)=>
    {
      if(sn.exists())
      {
        sn.forEach((element) => {
            l.push(
            {
              data:element.val(),
              devID:element.key
            });
        });
      }
     
    });
     return l;
  
 }
 function get_encoding(r_id,p_id)
 {
  const userId = FirebaseAuth.currentUser.uid;
  let encoding="";
  const defaultvalue="base64";
  let reference=ref(FireDb, `/users/${userId}/rooms/${r_id}/programs/${p_id}/program_encoding`);
  onValue (reference,(sn)=>{
    if(sn.exists())
    {
      encoding=sn.val();
    }
    else {
    set(reference,defaultvalue);
    encoding=defaultvalue;        
      }
  });
  return encoding;
 }

export {
    get_data_fromdb,
    get_data_from_allroomdb,
    get_data_fromroomdb,
    get_rooms ,
    get_encoding,
    get_data_fromroomitemdb
}
