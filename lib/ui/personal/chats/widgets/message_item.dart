import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/chat_message.data.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MessageItem extends StatelessWidget {
  final ChatMessageData message;
  final bool showDateTime;
  final ValueSetter<int> onTap;

  const MessageItem(this.message,
      {Key? key, this.showDateTime = false, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelf = message.senderId == locator<AuthenticationService>().user!.id;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment:
            isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => onTap(message.messageId!),
            child: IntrinsicWidth(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: Radius.circular(isSelf ? 25 : 0),
                    bottomRight: Radius.circular(isSelf ? 0 : 25),
                  ),
                  color: isSelf ? AppColor.primary : Colors.grey[300],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.messageContent!,
                        style: TextStyle(
                          color: isSelf ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            message.postedDatetime.toString().substring(10, 16),
                            style: TextStyle(
                                fontSize: 10,
                                color: isSelf ? Colors.white : Colors.grey),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          if (isSelf)
                            if (message.reviewStatus.toString() == '0')
                              Icon(
                                MdiIcons.check,
                                size: 13,
                              ),
                          if (isSelf)
                            if (message.reviewStatus.toString() == '1')
                              Icon(
                                MdiIcons.checkAll,
                                size: 13,
                                color: Colors.white,
                              ),
                        ],
                      )
                    ]),
              ),
            ),
          ),
          if (showDateTime) const SizedBox(height: 5),
        ],
      ),
    );
  }
}
