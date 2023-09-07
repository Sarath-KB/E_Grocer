package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;
import androidx.drawerlayout.widget.DrawerLayout;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class OrderDetails extends AppCompatActivity implements View.OnClickListener {

    String orderid;
    TextView oid,floc,tloc,status,time,custphno;
    Button accept,reject;
    String oid1,pname1,pamt1,custname1,custphno1,floc1,tloc1,status1,time1;
    DrawerLayout drawerLayout;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_order_details);

        drawerLayout = findViewById(R.id.drawer_loayout);
        Intent i = getIntent();
        orderid = i.getStringExtra("orderid");

        Log.d("orderid",orderid);

        accept=(Button) findViewById(R.id.accept);
        reject=(Button) findViewById(R.id.reject);
        oid=(TextView)findViewById(R.id.orderid);
        floc=(TextView)findViewById(R.id.flocation);
        tloc=(TextView)findViewById(R.id.tlocation);
        time=(TextView)findViewById(R.id.time);
        status=(TextView)findViewById(R.id.status);
        custphno=(TextView)findViewById(R.id.contact);


        details a=new details();
        a.execute(orderid);

        accept.setOnClickListener(this);
        reject.setOnClickListener(this);


    }

    @Override
    public void onClick(View view) {
        if(view == accept){

            acceptDetails e = new acceptDetails();
            e.execute(orderid);

        }else{
            rejectDetails e = new rejectDetails();
            e.execute(orderid);
        }
    }

    public class details extends AsyncTask<String,String,String> {

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb= new WebServiceCaller(getApplicationContext());
            wb.setSoapObject("orderdetails");
            wb.addProperty("orderid",strings[0]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            Log.d("details",s);
            JSONArray job= null;
            try{
                job=new JSONArray(s);
                JSONObject jo=job.getJSONObject(0);
                oid1=jo.getString("orderid");
                custphno1=jo.getString("cphno");
                time1=jo.getString("time");
                status1=jo.getString("status");
                floc1=jo.getString("floc");
                tloc1=jo.getString("tloc");



                oid.setText(oid1);

                time.setText(time1);
                status.setText(status1);
                floc.setText(floc1);
                tloc.setText(tloc1);
                custphno.setText(custphno1);


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
        Homepage.redirectActivity(this,UserProfile.class);
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


    class rejectDetails extends AsyncTask<String,String,String> {
        @Override
        protected String doInBackground(String... params) {
            WebServiceCaller caller=new WebServiceCaller(getApplicationContext());
            caller.setSoapObject("custreject");
            caller.addProperty("orderid",params[0]);

            caller.callWebService();
            String res= caller.getResponse();
            return res;
        }

        @Override
        protected void onPostExecute(String result) {
            super.onPostExecute(result);
            if(result.equals("Success")){
                Toast.makeText(getApplicationContext(), "Order Rejected", Toast.LENGTH_SHORT).show();
                Intent intent=new Intent(getApplicationContext(),Homepage.class);
                startActivity(intent);
            }
            else{
                Toast.makeText(getApplicationContext(), "Failed", Toast.LENGTH_SHORT).show();
            }

        }

    }


    class acceptDetails extends AsyncTask<String,String,String> {
        @Override
        protected String doInBackground(String... params) {
            WebServiceCaller caller=new WebServiceCaller(getApplicationContext());
            caller.setSoapObject("custaccept");
            caller.addProperty("orderid",params[0]);

            caller.callWebService();
            String res= caller.getResponse();
            return res;
        }

        @Override
        protected void onPostExecute(String result) {
            super.onPostExecute(result);
            if(result.equals("Success")){
                Toast.makeText(getApplicationContext(), "Order Accepted", Toast.LENGTH_SHORT).show();
                Intent intent=new Intent(getApplicationContext(),Homepage.class);
                startActivity(intent);
            }
            else{
                Toast.makeText(getApplicationContext(), "Failed", Toast.LENGTH_SHORT).show();
            }

        }

    }

}