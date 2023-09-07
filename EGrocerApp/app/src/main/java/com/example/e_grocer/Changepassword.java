package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;
import androidx.drawerlayout.widget.DrawerLayout;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class Changepassword extends AppCompatActivity {

    Button changeButton;
    EditText oldpwd,newpwd,cpwd;
    String oldpwd1,newpwd1,cpwd1,cid;
    String sh_name="MySh";

    DrawerLayout drawerLayout;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_changepassword);

        drawerLayout = findViewById(R.id.drawer_loayout);
        oldpwd = findViewById(R.id.currentpwd);
        newpwd = findViewById(R.id.newpwd);
        cpwd = findViewById(R.id.confirmpwd);
        changeButton = findViewById(R.id.change);
        SharedPreferences sh=getSharedPreferences(sh_name,MODE_PRIVATE);
        cid=sh.getString("userid","");

        changeButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                oldpwd1 = oldpwd.getText().toString();
                newpwd1 = newpwd.getText().toString();
                cpwd1 = cpwd.getText().toString();

                if(newpwd1.equals(cpwd1)) {
                    Changepwd s = new Changepwd();
                    s.execute(oldpwd1,newpwd1,cpwd1,cid);
                }
                else{
                    Toast.makeText(getApplicationContext(), "please confirm your password!", Toast.LENGTH_SHORT).show();
                }


            }
        });


    }


    class Changepwd extends AsyncTask<String,String,String> {
        @Override
        protected String doInBackground(String... params) {
            WebServiceCaller caller = new WebServiceCaller(getApplicationContext());
            caller.setSoapObject("changepassword");
            caller.addProperty("currentpassword", params[0]);
            caller.addProperty("newpassword", params[1]);
            caller.addProperty("confirmpassword", params[2]);
            caller.addProperty("userid", params[3]);


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
                Intent intent=new Intent(getApplicationContext(),Homepage.class);
                startActivity(intent);
            }

            //Toast.makeText(getApplicationContext(), result, Toast.LENGTH_LONG).show();
        }

    }


    public  void ClickMenu(View view){
        Homepage.openDrawer(drawerLayout);

    }

    public void ClickLogo(View view){

        Homepage.closeDrawer(drawerLayout);
    }

    public void ClickHome(View view){
        Homepage.redirectActivity(this,Homepage.class);
    }
    public void ClickProfile(View view){
        Homepage.redirectActivity(this,UserProfile.class);
    }
    public void ClickEdit(View view){
        Homepage.redirectActivity(this,EditProfile.class);
    }
    public void ClickPassword(View view){
        recreate();

    }
    public void ClickShop(View view){

        Homepage.redirectActivity(this,ShopDetails.class);
    }
    public void ClickAccept(View view){

        Homepage.redirectActivity(this,AcceptedOrder.class);
    }

    public void ClickLogout(View view){

        Homepage.logout(this);
    }

    protected  void onPaused(){
        super.onPause();
        Homepage.closeDrawer(drawerLayout);
    }



}
