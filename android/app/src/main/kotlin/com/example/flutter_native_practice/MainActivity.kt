package com.example.flutter_native_practice

import android.content.Intent
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  private val messagesChannel = "messagesChannel"
  private val sendMessageToAndroidMethod = "sendMessageToAndroidMethod"
  private val receiveMessageToAndroidMethod = "receiveMessageToAndroidMethod"
  private val activitiesChannel = "activitiesChannel"
  private val openAndroidActivityMethod = "openAndroidActivityMethod"

  var publicResult: MethodChannel.Result? = null

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    val channel: MethodChannel =
      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, messagesChannel)

    val activitiesChannel: MethodChannel =
      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, activitiesChannel)

    channel.setMethodCallHandler { call, result ->
      if (call.method == sendMessageToAndroidMethod) {

        var args: Map<String, String> = call.arguments as Map<String, String>

        Toast.makeText(this, args["message"], Toast.LENGTH_SHORT).show()

      }

      if (call.method == receiveMessageToAndroidMethod) {

        val map: Map<String, String> = mapOf("message" to "Hello from android")
        result.success(map)

      }

    }

    activitiesChannel.setMethodCallHandler { call, result ->
      if (call.method == openAndroidActivityMethod) {
        publicResult = result
        startActivityForResult(Intent(this, TestActivity::class.java), 1)

      }
    }

  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    super.onActivityResult(requestCode, resultCode, data)
      if(resultCode == 1){

      data?.getStringExtra("message")?.let {

        publicResult?.success(it)

      }

    }
  }
}
