package com.example.e_grocer;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

import java.util.List;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

public class AdapterAccept extends  RecyclerView.Adapter<AdapterAccept.MyViewHolder>{

    Context context;
    BeanAccept cbc;
    List<BeanAccept> lcb;

    public AdapterAccept(List<BeanAccept> lbc, Context applicationContext) {
        this.lcb=lbc;
        this.context=applicationContext;
    }

    @NonNull
    @Override
    public AdapterAccept.MyViewHolder onCreateViewHolder(@NonNull  ViewGroup parent, int viewType) {
        View itemView= LayoutInflater.from(parent.getContext()).inflate(R.layout.single_acceptedorder,parent,false);
        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull AdapterAccept.MyViewHolder holder, int position) {

        cbc=lcb.get(position);
        holder.orderid.setText(cbc.getOrderid());
        holder.custname.setText(cbc.getCustname());
        holder.custphno.setText(cbc.getCustphno());
        holder.status.setText(cbc.getStatus());
        holder.time.setText(cbc.getTime());
        holder.amt.setText(cbc.getAmount());
    }

    @Override
    public int getItemCount() {
        return lcb.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        TextView orderid,custname,custphno,time,status,amt;
        CardView click;
        public MyViewHolder(@NonNull View itemView) {

            super(itemView);
            click=(CardView) itemView.findViewById(R.id.click);
            orderid=(TextView)itemView.findViewById(R.id.orderid);
            custname=(TextView)itemView.findViewById(R.id.customer);
            custphno=(TextView)itemView.findViewById(R.id.contact);
            status=(TextView)itemView.findViewById(R.id.status);
            amt=(TextView)itemView.findViewById(R.id.amt);
            time=(TextView)itemView.findViewById(R.id.time);

            click.setOnClickListener(this);
        }


        @Override
        public void onClick(View view) {
            int a=getAdapterPosition();
            cbc=lcb.get(a);
            String orderid=cbc.getOrderid();
            if(view == click){
                Intent i=new Intent(context,OrderDetails.class);
                i.putExtra("orderid",orderid);
                view.getContext().startActivity(i);
            }
        }
    }
}
