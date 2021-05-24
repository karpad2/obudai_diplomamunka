<template>
  <app-layout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">Cameras</h2>
    </template>

    <div class="py-12">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
          <div>
            <div class="bg-white shadow-md rounded my-6">
              <table class="min-w-max w-full table-auto">
                <thead>
                  <tr>
                    <th class="w-1/4 ...">#</th>
                    <th class="w-1/3 ...">Name:</th>
                    <th class="w-1/3 ...">Camera Show</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(row, index) in cameras" :key="row.id">
                    <td>{{ index + 1 }}</td>
                    <td>{{ row.name }}</td>
                    <td>
                      <jet-button v-on:click="open_camera(row.id)"
                        >Show camera
                        <BIconArrowRightSquareFill class="" />
                      </jet-button>
                    </td>
                  </tr>
                </tbody>
                <tfoot>
                  <tr>
                    <td class="w-1/3 ..."></td>
                    <inertia-link
                      class="inline-flex items-center px-4 py-2 bg-gray-800 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700 active:bg-gray-900 focus:outline-none focus:border-gray-900 focus:shadow-outline-gray disabled:opacity-25 transition ease-in-out duration-150 ml-4"
                    ></inertia-link>
                    <td class="w-1/3 ..."></td>

                    <td class="w-1/5 ..."></td>
                  </tr>
                </tfoot>
              </table>
              <Cameraimage
                :show="camera_show"
                camera_name="camera_name"
                imgUrl="cameraimgUrl"
                @close="closeModal"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </app-layout>
</template>

<script>
import { Inertia } from "@inertiajs/inertia";
import axios from "axios";
import AppLayout from "@/Layouts/AppLayout";
import Welcome from "@/Jetstream/Welcome";
import JetLabel from "@/Jetstream/Label";
import JetButton from "@/Jetstream/Button";
import JetInput from "@/Jetstream/Input";
import { BIconArrowRightSquareFill } from "bootstrap-icons-vue";

import Button from "../Jetstream/Button";
import Cameraimage from "@/Jetstream/Cameraimage";

export default {
  props: {
    cameras: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      add_name: "",
      camera_show: false,
      camera_name: "",
      cameraimgUrl: "",
    };
  },
  mounted: () => {
    //console.log(rows);
  },
  components: {
    Button,
    AppLayout,
    JetButton,
    JetInput,
    JetLabel,
    BIconArrowRightSquareFill,
    Cameraimage,
  },
  methods: {
    open_camera(id) {
      let tmp = 0,
        l = 0;

      this.cameras.forEach((element) => {
        if (element.id == id) tmp = this.cameras[l];
        l++;
      });

      console.log(tmp);
      let url = tmp.url;
      //console.log("Opening popup");
      //let new_window = window.open("about:blank", tmp.name, 'width=300,height=300');

      //new_window.document.write("<Cameraimage />");
      this.camera_show = true;
      this.camera_name = tmp.name;
      this.cameraimgUrl = tmp.url;
    },
    closeModal() {
      this.camera_show = false;
    },
  },
};
</script>
