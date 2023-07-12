import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../../shared/styles/IconBroken.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: true,
      fallback: (context)=>CircularProgressIndicator(
        color: Colors.deepOrange,
      ),
      builder:(context)=> Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image.network(
                  'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                  fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Comunicate with Friends',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                )
              ]
            ),
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
              itemBuilder: (context,index)=>postItemModel(context),
              separatorBuilder: (context,index)=>SizedBox(
                height: 10,
              ),
              itemCount: 10),
          SizedBox(
              height: 10
          )
        ],
      ),
    );
  }

  Widget postItemModel(context)=>Card(
    elevation: 5,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg'

                ),
                radius: 25,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Alaa Mohamed',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      CircleAvatar(
                        radius: 7,
                        child: Icon(
                          Icons.check,
                          size: 10,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'January 21,2022 at 11:00 pm',
                    style: Theme.of(context).textTheme.caption,
                  ),

                ],
              ),
              Spacer(),
              IconButton
                (
                  onPressed: (){},
                  icon: Icon(
                      Icons.more_horiz
                  ))
            ],
          ),
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
            width: double.infinity,
            margin: EdgeInsets.all(
                10
            ),
          ),
          Text(
              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ',
              style: Theme.of(context).textTheme.bodyText1
          ),
          Wrap(
            children:List.generate(3, (index) =>  Container(
              height: 20,
              child: MaterialButton(
                height: 5,
                padding: EdgeInsets.zero,
                onPressed: (){},
                child: Text(
                  '#Software_development',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 11
                  ),
                ),
              ),
            )),
          ),
          Image.network(
            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap:(){},
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color:Colors.red,
                        size: 20,
                      ),
                      Text(
                        '1200',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        IconBroken.Chat,
                        color:Colors.amber,
                        size: 20,
                      ),
                      Text(
                        '1200 comment',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
            width: double.infinity,
            margin: EdgeInsets.all(
                10
            ),
          ),
          InkWell(
            onTap: (){},
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg'

                  ),
                  radius: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Write a comment...',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );

}
