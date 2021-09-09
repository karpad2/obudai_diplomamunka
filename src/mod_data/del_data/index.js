
import {FireDb,FirebaseAuth,userId} from "@/firebase";
import {ref, set ,onValue,get, child,push,runTransaction } from "firebase/database";
import router from "@/router";


function deletep(k)
{
    const userId = FirebaseAuth.currentUser.uid;
   // let _ref= ref(FireDb, `/users/${userId}/rooms/${room_id}`);
   let _ref= ref(FireDb, `/users/${userId}/${k}`);
    set(_ref,null);
    router.go(-1); 
}
function delete_room(room_id)
{
console.log("Delete room");
//const room_id=this.$route.params.rid;
 deletep(`rooms/${room_id}`);   
}
function delete_device(room_id,devID)
                {
                    deletep(`rooms/${room_id}/devices/${devID}`);
                }
export{
    delete_room,
    delete_device
}
