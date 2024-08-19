import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_cloud_clone/models/user_model.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://th.bing.com/th/id/R.28b96f1c49c31622589fe9ea4b00dc71?rik=%2b48fTHbS88tJjQ&riu=http%3a%2f%2fimages4.fanpop.com%2fimage%2fphotos%2f19500000%2fTobi-tobi-19529893-1280-720.jpg&ehk=9Sr7gbjRKCuflqYyYB4zHwSMMtFAgQqCmuej9DqkdYs%3d&risl=&pid=ImgRaw&r=0',
          height: 100,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.bing.com/images/search?view=detailV2&ccid=y1Q09f7N&id=EF393C0CB44453673C7905618BA3E5A30AB00321&thid=OIP.y1Q09f7NYYvYaZcOWWExygHaEK&mediaurl=https%3a%2f%2fimages.wallpapersden.com%2fimage%2fdownload%2fmadara-uchiha-cool-artwork_bGlnbGaUmZqaraWkpJRobWllrWdma2U.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.cb5434f5fecd618bd869970e596131ca%3frik%3dIQOwCqPlo4thBQ%26pid%3dImgRaw%26r%3d0&exph=2160&expw=3840&q=madara+uchiha&simid=608014086875448513&FORM=IRPRST&ck=7A99CD041DBA056DB67E550901A89363&selectedIndex=1&itb=0'),
                radius: 42,
              ),
              const Gap(20),
              Text('tobi uchiha',
                  style: Theme.of(context).textTheme.displayMedium),
              Text(
                'ohio, United States',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              const Gap(10),
              Text(
                '17 Followers - 6 Following',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        )
      ],
    );
  }
}
