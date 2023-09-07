package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.squareup.picasso.Picasso;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class ForgotPassword extends AppCompatActivity implements View.OnClickListener {

    EditText fname;
    Button btnsubmit;
    String fogot,otp,userid;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_forgot_password);

        fname = findViewById(R.id.et_email);
        btnsubmit = findViewById(R.id.forgotButton);

        btnsubmit.setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {
        fogot = fname.getText().toString();
        fpwdDetails a=new fpwdDetails();
        a.execute(fogot);
    }

    class fpwdDetails extends AsyncTask<String,String,String> {
        @Override
        protected String doInBackground(String... params) {
            WebServiceCaller caller=new WebServiceCaller(getApplicationContext());
            caller.setSoapObject("sendmail");
            caller.addProperty("email",params[0]);
            caller.callWebService();
            String res= caller.getResponse();
            return res;
        }

        @Override
        protected void onPostExecute(String result) {
            super.onPostExecute(result);

            JSONArray job= null;
            try{
                job=new JSONArray(result);
                JSONObject jo=job.getJSONObject(0);
                otp=jo.getString("otp");
                userid=jo.getString("userid");

            }catch(JSONException e){
                e.printStackTrace();
            }

            Intent i=new Intent(ForgotPassword.this,OTPVerification.class);
            i.putExtra("otp",otp);
            i.putExtra("userid",userid);
            startActivity(i);
        }

    }

}