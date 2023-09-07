package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;
import androidx.drawerlayout.widget.DrawerLayout;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;

import com.squareup.picasso.Picasso;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class UserProfile extends AppCompatActivity {

    EditText name,contact,email,address;
    ImageView image;
    String cid,cname,caddress,ccontact,cemail,cphoto;
    String ip;
    DrawerLayout drawerLayout;

    String sh_name="MySh";
    Context context;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_user_profile);

        drawerLayout = findViewById(R.id.drawer_loayout);
        name = findViewById(R.id.et_fullname);
        contact = findViewById(R.id.et_mcontact);
        email = findViewById(R.id.et_memail);
        image = findViewById(R.id.photo);
        address = findViewById(R.id.et_maddress);

        SharedPreferences sh=getSharedPreferences(sh_name,MODE_PRIVATE);
        cid=sh.getString("userid","");

        myprofile a=new myprofile();
        a.execute(cid);
    }


    public class myprofile extends AsyncTask<String,String,String> {

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb= new WebServiceCaller(getApplicationContext());
            wb.setSoapObject("myprofile");
            wb.addProperty("userid",strings[0]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            JSONArray job= null;
            try{
                job=new JSONArray(s);
                JSONObject jo=job.getJSONObject(0);
                cname=jo.getString("name");
                cphoto=jo.getString("photo");
                caddress=jo.getString("address");
                ccontact=jo.getString("contact");
                cemail=jo.getString("email");


                name.setText(cname);
                contact.setText(ccontact);
                email.setText(cemail);
                address.setText(caddress);

                Picasso.get().load("http://192.168.1.6:8084/E-Grocer/Assets/Delivery Agent/"+cphoto).into(image);



            }catch(JSONException e){
                e.printStackTrace();
            }

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
        recreate();
    }
    public void ClickEdit(View view){
        Homepage.redirectActivity(this,EditProfile.class);
    }
    public void ClickPassword(View view){

        Homepage.redirectActivity(this,Changepassword.class);
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