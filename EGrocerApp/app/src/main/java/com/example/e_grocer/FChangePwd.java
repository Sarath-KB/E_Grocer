package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class FChangePwd extends AppCompatActivity {

    String userid;
    Button changeButton;
    EditText newpwd,cpwd;
    String  newpwd1,cpwd1,cid;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fchange_pwd);

        Intent i = getIntent();
        userid = i.getStringExtra("userid");

        newpwd = findViewById(R.id.newpwd);
        cpwd = findViewById(R.id.confirmpwd);
        changeButton = findViewById(R.id.change);

        changeButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                newpwd1 = newpwd.getText().toString();
                cpwd1 = cpwd.getText().toString();

                if(newpwd1.equals(cpwd1)) {
                    Changepwd s = new Changepwd();
                    s.execute(newpwd1,cpwd1,userid);
                }
                else{
                    Toast.makeText(getApplicationContext(), "New password and Confirm password mismatch!", Toast.LENGTH_SHORT).show();
                }


            }
        });
    }

    class Changepwd extends AsyncTask<String,String,String> {
        @Override
        protected String doInBackground(String... params) {
            WebServiceCaller caller = new WebServiceCaller(getApplicationContext());
            caller.setSoapObject("fchangepassword");
             caller.addProperty("newpassword", params[0]);
            caller.addProperty("confirmpassword", params[1]);
            caller.addProperty("userid", params[2]);


            caller.callWebService();
            String res = caller.getResponse();
            return res;
        }

        @Override
        protected void onPostExecute(String result) {
            super.onPostExecute(result);

            if(result.equals("Fail"))
            {
                Toast.makeText(getApplicationContext(), "Incorrect Password", Toast.LENGTH_SHORT).show();
            }
            else
            {
                Toast.makeText(getApplicationContext(), "Password Changed Successfully", Toast.LENGTH_SHORT).show();
                Intent intent=new Intent(getApplicationContext(),Login.class);
                startActivity(intent);
            }

            //Toast.makeText(getApplicationContext(), result, Toast.LENGTH_LONG).show();
        }

    }



}