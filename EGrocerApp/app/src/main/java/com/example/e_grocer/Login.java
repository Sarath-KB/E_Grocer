package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.textfield.TextInputEditText;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Login extends AppCompatActivity implements View.OnClickListener {

    TextInputEditText lusername,lpassword;
    Button btnSubmit,btnsignup;
    String Username,Password;
    String userid,res;
    String sh_name="MySh";
    TextView fwdPassword;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        lusername=(TextInputEditText)findViewById(R.id.et_username);
        lpassword=(TextInputEditText) findViewById(R.id.et_password);
        btnSubmit=(Button) findViewById(R.id.btn_login);
        btnsignup=(Button) findViewById(R.id.btn_signup);
        fwdPassword = findViewById(R.id.forgotpwd);
        btnSubmit.setOnClickListener(this);
        btnsignup.setOnClickListener(this);
        fwdPassword.setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {
        if(view==btnSubmit)
        {
            Username=lusername.getText().toString();
            Password=lpassword.getText().toString();

            LoginForm s=new LoginForm();
            s.execute(Username,Password);

        }
        if(view==btnsignup)
        {
            Intent i=new Intent(Login.this,Registration.class);
            startActivity(i);
        }
        if(view==fwdPassword)
        {
            Intent i=new Intent(Login.this,ForgotPassword.class);
            startActivity(i);
        }
    }

    public class LoginForm extends AsyncTask<String,String,String>
    {
        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb=new WebServiceCaller(getApplicationContext());
            wb.setSoapObject("Login");
            wb.addProperty("username",strings[0]);
            wb.addProperty("password",strings[1]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);

            Toast.makeText(Login.this, "S="+s, Toast.LENGTH_SHORT).show();

            if(!s.equals("[]"))
            {
                try
                {
                    JSONArray job=new JSONArray(s);
                    JSONObject jo=job.getJSONObject(0);
                    userid=jo.getString("user_id");


                }
                catch (JSONException e)
                {
                    e.printStackTrace();
                }

                SharedPreferences sh=getSharedPreferences(sh_name,MODE_PRIVATE);
                SharedPreferences.Editor editor=sh.edit();
                editor.putString("userid",userid);
                editor.commit();

                Intent i=new Intent(Login.this,Homepage.class);
                startActivity(i);
                Toast.makeText(Login.this, "userid"+userid, Toast.LENGTH_SHORT).show();
            }
            else
            {
                Toast.makeText(Login.this, "Failed", Toast.LENGTH_SHORT).show();
            }
        }
    }
}
