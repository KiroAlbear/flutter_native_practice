package com.example.flutter_native_practice

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import com.google.android.material.button.MaterialButton
import com.google.android.material.textfield.TextInputEditText

class TestActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_test)
        val  loginButton:MaterialButton = findViewById(R.id.loginButton);
        val username:TextInputEditText = findViewById(R.id.username);

        loginButton.setOnClickListener {
            // start practice activity
//            startActivity(Intent(this, PracticeActivity::class.java))
           
            val intent = Intent()
            intent.putExtra("message", username.text.toString())
            setResult(1, intent)
            finish()
        }
    }
}