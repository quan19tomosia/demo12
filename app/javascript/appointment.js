window.addEventListener("load", (event) => {
  $("#appointment_patient_id").on("change", function(){
    if(this.value != ""){
      var patient_id = this.value;

      $.ajax({
        url: "/patients/" + patient_id,
        type: "GET",
        dataType: "json",
        data: {
          patient_id: patient_id,
        },
        success: function(res){
          console.log(res);
        },
        error: function(res){
          alert("Something happened " + res)
        }
      })

      $("#div-patient").show();
    }
    else {
      $("#div-patient").hide();
    }
  });

  $("#appointment_physician_id").on("change", function(){
    if(this.value != ""){
      var physician_id = this.value;

      $.ajax({
        url: "/physicians/" + physician_id,
        type: "GET",
        dataType: "json",
        data: {
          physician_id: physician_id,
        },
        success: function(res){
          console.log(res);
        },
        error: function(res){
          alert(res);
        }
      })

      $("#div-physician").show();
      $("#div-schedule").show();
    }
    else {
      $("#div-physician").hide();
      $("#div-schedule").hide();
    }
  })

  $("#appointment_schedule_day").on("change", function(){
    var physician_id = $("#appointment_physician_id").val();

    if(this.value != ""){
      $.ajax({
        url: "/check",
        type: "GET",
        dataType: "json",
        data: {
          physician_id: physician_id,
          date: this.value,
        },
        success: function(res){
          console.log(res)
        },
        error: function(res){
          alert("Something happened" + res);
        }
      })

      $("#appointment_schedule_time").show();
    }
    else {
      $("#appointment_schedule_time").hide();
    }
  })
})
