package com.ostarsier.servlet;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class TestLottery {
	static final int TIME = 100000;
    
    public static void iteratorMap(Map<Integer, Integer> map, List<Double> list){  
        for(Entry<Integer, Integer> entry : map.entrySet()){  
            int index = entry.getKey();  
            int time  = entry.getValue();  
            Result result = new Result(index, TIME, time, list.get(index));  
            System.out.println(result);  
        }  
    }  
      
    public static void main(String[] args) {  
        //构造概率集合  
        List<Double> list = new ArrayList<Double>();  
        list.add(20d);  
        list.add(80d);  
        list.add(80d);  
        list.add(30d);  
        LotteryUtil ll = new LotteryUtil(list);  
        double sumProbability = ll.getMaxElement();  
          
        Map<Integer, Integer> map = new HashMap<Integer, Integer>();  
        for(int i = 0; i < TIME; i++){  
            int index = ll.randomColunmIndex();
            if(map.containsKey(index)){  
                map.put(index, map.get(index) + 1);
            }else{  
                map.put(index, 1);
            }  
        }  
        for(int i = 0; i < list.size(); i++){
            double probability = list.get(i) / sumProbability;
            list.set(i, probability);
        }
        iteratorMap(map, list);

    }
}
