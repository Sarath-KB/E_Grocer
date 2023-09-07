package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class OTPVerification extends AppCompatActivity implements View.OnClickListener {

    EditText otpnumber;
    String otp,otp1,userid;
    Button otpButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_otpverification);

        otpnumber = findViewById(R.id.et_otp);
        otpButton = findViewById(R.id.otpButton);

        otpButton.setOnClickListener(this);

        Intent i = getIntent();
        otp = i.getStringExtra("otp");
        userid = i.getStringExtra("userid");


    }

    @Override
    public void onClick(View view) {
        otp1 = otpnumber.getText().toString();
        if(otp.equals(otp1)){
            Intent i=new Intent(OTPVerification.this,FChangePwd.class);
            i.putExtra("userid",userid);
            startActivity(i);
        }
        else{
            Toast.makeText(getApplicationContext(), "Incorrect OTP", Toast.LENGTH_SHORT).show();

        }
    }


}