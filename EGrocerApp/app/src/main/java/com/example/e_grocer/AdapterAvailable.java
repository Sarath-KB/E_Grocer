package com.example.e_grocer;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;

import java.util.List;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

public class AdapterAvailable extends  RecyclerView.Adapter<AdapterAvailable.MyViewHolder>{
    Context context;
    BeanAvailable cbc;
    List<BeanAvailable> lcb;

    public AdapterAvailable(List<BeanAvailable> lbc, Context applicationContext) {
        this.lcb=lbc;
        this.context=applicationContext;
    }
    @NonNull
    @Override
    public AdapterAvailable.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView= LayoutInflater.from(parent.getContext()).inflate(R.layout.single_availability,parent,false);
        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull  AdapterAvailable.MyViewHolder holder, int position) {

        cbc=lcb.get(position);
        holder.orderid.setText(cbc.getOrderid());
        holder.floc.setText(cbc.getFloc());
        holder.tloc.setText(cbc.getTloc());
        holder.time.setText(cbc.getEtime());
        holder.status.setText(cbc.getStatus());


    }

    @Override
    public int getItemCount() {

        return lcb.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        TextView pname,pamt,orderid,floc,tloc,time,status;
        ImageView photo;
        Button accept;
        public MyViewHolder(View itemView) {
            super(itemView);
            accept=(Button) itemView.findViewById(R.id.accept);
            orderid=(TextView)itemView.findViewById(R.id.orderid);
            floc=(TextView)itemView.findViewById(R.id.flocation);
            tloc=(TextView)itemView.findViewById(R.id.tlocation);
            time=(TextView)itemView.findViewById(R.id.time);
            status=(TextView)itemView.findViewById(R.id.status);

            accept.setOnClickListener(this);
        }

        @Override
        public void onClick(View view) {
            String cid;
            String sh_name="MySh";
            SharedPreferences sh=context.getSharedPreferences(sh_name,context.MODE_PRIVATE);
            cid=sh.getString("userid","");

            int a=getAdapterPosition();
            cbc=lcb.get(a);
            String cartid=cbc.getOrderid();
            if(view == accept){
                acceptDetails e = new acceptDetails();
                e.execute(cid,cartid);
            }
        }

        class acceptDetails extends AsyncTask<String,String,String> {
            @Override
            protected String doInBackground(String... params) {
                WebServiceCaller caller=new WebServiceCaller(context.getApplicationContext());
                caller.setSoapObject("deliveryboyaccept");
                caller.addProperty("deliveryboyid",params[0]);
                caller.addProperty("cartid",params[1]);

                caller.callWebService();
                String res= caller.getResponse();
                return res;
            }

            @Override
            protected void onPostExecute(String result) {
                super.onPostExecute(result);
                if(result.equals("Success")){
                    Toast.makeText(context.getApplicationContext(), "Order Accepted", Toast.LENGTH_SHORT).show();
                    Intent intent=new Intent(context.getApplicationContext(),Homepage.class);
                    context.startActivity(intent);
                }
                else{
                    Toast.makeText(context.getApplicationContext(), "Failed", Toast.LENGTH_SHORT).show();
                }

            }

        }
    }
}
