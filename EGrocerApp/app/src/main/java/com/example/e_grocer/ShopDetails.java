package com.example.e_grocer;

import androidx.appcompat.app.AppCompatActivity;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class ShopDetails extends AppCompatActivity {


    RecyclerView rv;
    AdapterShop cadpt;
    List<BeanShop> lbc;
    String shopid[], shopname[], photo[],shopcontact[],shopemail[],available[],shopaddress[];
    String locid;
    DrawerLayout drawerLayout;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_shop_details);

        drawerLayout = findViewById(R.id.drawer_loayout);
        rv = (RecyclerView) findViewById(R.id.recyclerview);
        lbc = new ArrayList<>();


        shopdetails d = new shopdetails();
        d.execute(locid);
    }

        public class shopdetails extends AsyncTask<String, String, String> {

            @Override
            protected String doInBackground(String... params) {
                WebServiceCaller wb = new WebServiceCaller(getApplicationContext());
                wb.setSoapObject("shopdetails");
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

                        shopid = new String[ja.length()];
                        shopname = new String[ja.length()];
                        shopaddress = new String[ja.length()];
                        shopcontact = new String[ja.length()];
                        shopemail = new String[ja.length()];
                        available = new String[ja.length()];
                        photo = new String[ja.length()];

                        for (int i = 0; i < ja.length(); i++) {
                            jb = ja.getJSONObject(i);
                            shopid[i] = jb.getString("shopid");
                            shopname[i] = jb.getString("shopname");
                            shopcontact[i] = jb.getString("shopcontact");
                            shopemail[i] = jb.getString("shopemail");
                            available[i] = jb.getString("available");
                            photo[i] = jb.getString("shopimage");
                            shopaddress[i] = jb.getString("shopaddress");



                            BeanShop cbc = new BeanShop();

                            cbc.setShopid(shopid[i]);
                            cbc.setShopname(shopname[i]);
                            cbc.setShopaddress(shopaddress[i]);
                            cbc.setShopcontact(shopcontact[i]);
                            cbc.setShopemail(shopemail[i]);
                            cbc.setAvailable(available[i]);

                            cbc.setShopimage(photo[i]);


                            lbc.add(cbc);


                        }
                        cadpt = new AdapterShop(lbc, getApplicationContext());
                        rv.setLayoutManager(new LinearLayoutManager(ShopDetails.this));
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
       recreate();
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