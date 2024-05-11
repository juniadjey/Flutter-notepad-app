import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week1/constants/colors.dart';
import 'package:week1/models/notes.dart';
import 'package:week1/pages/edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List<Note> filterednotes=[];
  bool sorted=false;
  @override
  void initState(){
    super.initState();
    filterednotes=sampleNotes;
  }
  getRandomColor(){
    Random random =Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void onsearchtext( searchtext){
setState(() {
   filterednotes= sampleNotes.where((note) => 
    note.content.toLowerCase().contains(searchtext.toLowerCase()) ||
    note.title.toLowerCase().contains(searchtext.toLowerCase()) 
    ).toList();
});
  }

  List <Note> sortnotesbytime(List<Note>notes){
    if(sorted){
      notes.sort((a,b)=>a.modifiedTime.compareTo(b.modifiedTime));
    }
    else{
      notes.sort((b,a)=>a.modifiedTime.compareTo(b.modifiedTime));
    }
    sorted=!sorted;
  return notes;
  }

  void ondelete(int index){
    setState(() {
      Note note=filterednotes[index];
      sampleNotes.remove(note);
      filterednotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body:Padding(
        padding: const EdgeInsets.fromLTRB(16,40,16,0),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Notes',style: TextStyle(fontSize: 30,color: Colors.white),),
                IconButton(onPressed: (){
                setState(() {
                  filterednotes=sortnotesbytime(filterednotes);
                });

                }, 
                 padding: EdgeInsets.all(0),
                 icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: Colors.grey.shade800.withOpacity(.8),
                  borderRadius: BorderRadius.circular(10)),
                  
                  child: Icon(Icons.filter,color:Colors.white)))
              ],
            ),






            SizedBox(height: 20,),
            TextField(
              onChanged: (value){
                onsearchtext(value);
              },
              style: TextStyle(fontSize: 16,color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                hintText: "Search",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.grey.shade800,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent)
                ),
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent)),
              ),
            ),
      
           



                       SizedBox(height: 20,),

           Expanded(child: ListView.builder(
            
            padding: EdgeInsets.only(top: 30),
            itemCount: filterednotes.length,
            itemBuilder: (context, index) {
              return   Card(
                color: getRandomColor(),
                margin: const EdgeInsets.only(bottom: 20),
                 
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditScreen(note: filterednotes[index]),
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            int originalIndex =
                                sampleNotes.indexOf(filterednotes[index]);

                            sampleNotes[originalIndex] = Note(
                                id: sampleNotes[originalIndex].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now());
                                
                            filterednotes[index] = Note(
                                id: filterednotes[index].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now());
                          });
                        }
                      },
                      title: RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text:  TextSpan(
                        text: '${filterednotes[index].title} :\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 1.5
                        ),
                        children: [
                          TextSpan(
                            text: '${filterednotes[index].content}',
                            style: TextStyle(
                              color: Colors.black,
                                 fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 1.5
                    
                            )
                          )
                        ]
                      )),
                      subtitle:Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                    
                          ' Edited : ${DateFormat('EEE MMM d,h:mm a').format(filterednotes[index].modifiedTime)}',
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade800
                          ),
                        ),
                      ) ,
                     trailing: IconButton(
                        onPressed: () async {
                          final result = await confirmDialog(context);
                          if (result != null && result) {
                            ondelete(index);
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ),
                );
            },
            
           ))



          ],
        ),
      ),


   

    floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const EditScreen(),
            ),
          );

          if (result != null) {
            setState(() {
              sampleNotes.add(Note(
                  id: sampleNotes.length,
                  title: result[0],
                  content: result[1],
                  modifiedTime: DateTime.now()));
              filterednotes = sampleNotes;
            });
          }
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),



    );
  }
}


Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              'Are you sure you want to delete?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ]),
          );
        });
  }
