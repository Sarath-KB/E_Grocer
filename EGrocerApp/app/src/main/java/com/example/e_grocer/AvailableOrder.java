package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class AvailableOrder extends AppCompatActivity {

    RecyclerView rv;
    AdapterAvailable cadpt;
    List<BeanAvailable> lbc;
    String orderid[],shopaddress[],custaddress[],time[],status[];
    String shopid;

    DrawerLayout drawerLayout;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_available_order);

        rv = (RecyclerView) findViewById(R.id.recyclerview);
        lbc = new ArrayList<>();

        Intent i = getIntent();
        shopid = i.getStringExtra("shopid");

        Log.d("shopid",shopid);

        availableOrder d = new availableOrder();
        d.execute(shopid);

        drawerLayout = findViewById(R.id.drawer_loayout);

    }

    public class availableOrder extends AsyncTask<String, String, String> {

        @Override
        protected String doInBackground(String... params) {
            WebServiceCaller wb = new WebServiceCaller(getApplicationContext());
            wb.setSoapObject("availableorders");
            wb.addProperty("shopid",params[0]);
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
                    time = new String[ja.length()];
                    status = new String[ja.length()];
                    shopaddress = new String[ja.length()];
                    custaddress = new String[ja.length()];


                    for (int i = 0; i < ja.length(); i++) {
                        jb = ja.getJSONObject(i);
                        orderid[i] = jb.getString("orderid");
                        time[i] = jb.getString("time");
                        status[i] = jb.getString("status");
                        shopaddress[i] = jb.getString("saddress");
                        custaddress[i] = jb.getString("caddress");

                        BeanAvailable cbc = new BeanAvailable();

                        cbc.setOrderid(orderid[i]);
                        cbc.setEtime(time[i]);
                        cbc.setStatus(status[i]);
                        cbc.setFloc(shopaddress[i]);
                        cbc.setTloc(custaddress[i]);



                        lbc.add(cbc);


                    }
                    cadpt = new AdapterAvailable(lbc, getApplicationContext());
                    rv.setLayoutManager(new LinearLayoutManager(AvailableOrder.this));
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