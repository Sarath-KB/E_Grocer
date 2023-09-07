package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class AcceptedOrder extends AppCompatActivity {

    RecyclerView rv;
    AdapterAccept cadpt;
    List<BeanAccept> lbc;
    String orderid[],custname[],custphno[],status[],time[],amt[];
    String cid;
    String sh_name="MySh";

    DrawerLayout drawerLayout;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_accepted_order);
        drawerLayout = findViewById(R.id.drawer_loayout);
        rv = (RecyclerView) findViewById(R.id.recyclerview);
        lbc = new ArrayList<>();

        SharedPreferences sh=getSharedPreferences(sh_name,MODE_PRIVATE);
        cid=sh.getString("userid","");


        acceptOrder d = new acceptOrder();
        d.execute(cid);
    }

    public class acceptOrder extends AsyncTask<String, String, String> {

        @Override
        protected String doInBackground(String... params) {
            WebServiceCaller wb = new WebServiceCaller(getApplicationContext());
            wb.setSoapObject("acceptedorders");
            wb.addProperty("daid",params[0]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);

            if(s!=("[]")){
                try {
                    JSONArray ja = new JSONArray(s);
                    JSONObject jb;

                    orderid = new String[ja.length()];
                    status = new String[ja.length()];
                    custname = new String[ja.length()];
                    custphno = new String[ja.length()];
                    amt = new String[ja.length()];
                    time = new String[ja.length()];

                    for (int i = 0; i < ja.length(); i++) {
                        jb = ja.getJSONObject(i);
                        orderid[i] = jb.getString("orderid");
                        status[i] = jb.getString("status");
                        custname[i] = jb.getString("cname");
                        custphno[i] = jb.getString("cphno");
                        amt[i] = jb.getString("amt");
                        time[i] = jb.getString("time");


                        BeanAccept cbc = new BeanAccept();

                        cbc.setOrderid(orderid[i]);
                        cbc.setStatus(status[i]);
                        cbc.setCustname(custname[i]);
                        cbc.setCustphno(custphno[i]);
                        cbc.setAmount(amt[i]);
                        cbc.setTime(time[i]);


                        lbc.add(cbc);


                    }
                    cadpt = new AdapterAccept(lbc, getApplicationContext());
                    rv.setLayoutManager(new LinearLayoutManager(AcceptedOrder.this));
                    rv.setAdapter(cadpt);
                } catch (JSONException e) {
                    e.printStackTrace();
                }

            }
            else{
                Toast.makeText(getApplicationContext(), "No data found", Toast.LENGTH_SHORT).show();

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

       recreate();
    }

    public void ClickLogout(View view){

        Homepage.logout(this);
    }

    protected  void onPaused(){
        super.onPause();
        Homepage.closeDrawer(drawerLayout);
    }


}