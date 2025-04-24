import 'package:flutter/material.dart';
import 'package:luk/bean/game_info.dart';

/// 游戏列表弹窗
class GameListSheet extends StatelessWidget {
  final List<GameInfo> gameList;

  const GameListSheet({super.key, required this.gameList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(34), topRight: Radius.circular(34))),
      child: Column(
        children: [
          const SizedBox(
            height: 64,
            child: Center(
              child: Text(
                "游戏列表",
                style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
              child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 6 / 6),
            padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 22),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, gameList[index]);
                },
                child: SizedBox(
                  height: 80,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            gameList[index].icon,
                            width: 48,
                            height: 48,
                          ),
                        ),
                        Container(
                          height: 6,
                        ),
                        Text(
                          gameList[index].name,
                          style: const TextStyle(color: Colors.black, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: gameList.length,
          ))
        ],
      ),
    );
  }
}
