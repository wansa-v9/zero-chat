import 'package:flutter/material.dart';

void main() {
  runApp(const ZeroChatApp());
}

class ZeroChatApp extends StatelessWidget {
  const ZeroChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'زيرو دردشة - Zero Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A11CB),
          primary: const Color(0xFF6A11CB),
          secondary: const Color(0xFF2575FC),
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// 1. شاشة تسجيل الدخول والتعرف على صاحب التطبيق والمساعد
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const String ownerEmail = "abbas505minecraft196@gmail.com";
  static const String assistantEmail = "hossam1214253@gmail.com";

  void _login() {
    String email = _emailController.text.trim();
    String role = "عضو عادٍ";
    int dailyCounter = 200;

    if (email == ownerEmail) {
      role = "صاحب التطبيق";
      dailyCounter = 6000000;
    } else if (email == assistantEmail) {
      role = "مساعد صاحب التطبيق";
      dailyCounter = 2000000;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(userEmail: email, userRole: role, dailyCounter: dailyCounter),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'زيرو دردشة',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 2. الصفحة الرئيسية
class HomeScreen extends StatelessWidget {
  final String userEmail;
  final String userRole;
  final int dailyCounter;

  const HomeScreen({
    super.key,
    required this.userEmail,
    required this.userRole,
    required this.dailyCounter,
  });

  @override
  Widget build(BuildContext context) {
    bool isOwner = userEmail == "abbas505minecraft196@gmail.com";

    return Scaffold(
      appBar: AppBar(
        title: Text('أهلاً بك - $userRole'),
        backgroundColor: const Color(0xFF6A11CB),
        actions: [
          if (isOwner)
            IconButton(
              icon: const Icon(Icons.admin_panel_settings, color: Colors.amber),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OwnerDashboardScreen()),
                );
              },
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.white.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('البريد: $userEmail', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 😎,
                  Text('العداد اليومي: $dailyCounter عملة ذهبية', style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2575FC), foregroundColor: Colors.white),
            onPressed: () {
              // الانتقال لإنشاء غرفة (غرفة واحدة للمستخدم)
            },
            icon: const Icon(Icons.add_circle),
            label: const Text('إنشاء غرفة جديدة (بسعر 20,000 عملة)'),
          ),
          const SizedBox(height: 20),
          const Text('الغرف المتاحة:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildRoomTile(context, 'غرفة الدعم (70 شخص)', 'الدعم الفني'),
          _buildRoomTile(context, 'الغرفة العامة (60 شخص - بدون هدايا)', 'عامة'),
          _buildRoomTile(context, 'غرفة الدردشة (60 شخص - بدون هدايا)', 'دردشة'),
        ],
      ),
    );
  }

  Widget _buildRoomTile(BuildContext context, String name, String type) {
    return Card(
      color: const Color(0xFF1E293B),
      child: ListTile(
        title: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.amber),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LiveRoomScreen(roomName: name, roomType: type),
            ),
          );
        },
      ),
    );
  }
}

// 3. لوحة تحكم صاحب التطبيق
class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  final TextEditingController _assistantEmailController = TextEditingController();
  final List<String> assistants = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم صاحب التطبيق'),
        backgroundColor: const Color(0xFF6A11CB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('تعيين مساعد لصاحب التطبيق (تحويل كوينز بلا حدود):', style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _assistantEmailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني للمساعد',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_assistantEmailController.text.isNotEmpty) {
                  setState(() {
                    assistants.add(_assistantEmailController.text.trim());
                    _assistantEmailController.clear();
                  });
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
              child: const Text('إضافة كمساعد'),
            ),
            const SizedBox(height: 20),
            const Text('المساعدون الحاليون:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ...assistants.map((e) => ListTile(
                  title: Text(e, style: const TextStyle(color: Colors.white70)),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                )),
          ],
        ),
      ),
    );
  }
}

// 4. واجهة الغرفة الحية
class LiveRoomScreen extends StatefulWidget {
  final String roomName;
  final String roomType;

  const LiveRoomScreen({super.key, required this.roomName, required this.roomType});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  int likeCount = 0;
  bool isJoined = false;
  final List<String> messages = [];
  final TextEditingController _msgController = TextEditingController();

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E293B),
            title: const Text('خروج من الغرفة', style: TextStyle(color: Colors.white)),
            content: const Text('هل تريد الخروج من الغرفة؟', style: TextStyle(color: Colors.white70)),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('إلغاء')),
              TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('خروج', style: TextStyle(color: Colors.red))),
            ],
          ),
        ) ??
        false;
  }

  void _showGiftsDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        height: 300,
        child: Column(
          children: [
            const Text('الهدايا (ثابتة ومتحركة بدقة 4K)', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: ['أسد', 'تمساح', 'دجاجة', 'بيضة', 'طابوقة', 'نعال', 'خروف', 'هدية متحركة']
                    .map((gift) => Card(
                          color: Colors.purple.shade900,
                          child: Center(
                            child: Text(gift, style: const TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF6A11CB),
          title: Text(widget.roomName, style: const TextStyle(fontSize: 16)),
          actions: [
            IconButton(
              icon: Icon(isJoined ? Icons.check : Icons.add, color: Colors.amber),
              onPressed: () => setState(() => isJoined = !isJoined),
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () => setState(() => likeCount++),
            ),
            Center(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 😎, child: Text('$likeCount'))),
          ],
        ),
        body: Column(
          children: [
            Container(
              color: Colors.black38,
              padding: const EdgeInsets.all(6),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.leaderboard, color: Colors.amber, size: 18),
                  SizedBox(width: 6),
                  Text('المتصدرون في الهدايا', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(4, (index) => Column(
                  children: [
                    CircleAvatar(radius: 24, backgroundColor: Colors.purple.shade300, child: Text('مايك ${index + 1}', style: const TextStyle(fontSize: 10))),
                    const Text('فارغ', style: TextStyle(fontSize: 9, color: Colors.white54)),
                  ],
                )),
              ),
            ),
            const Divider(color: Colors.white24),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) => ListTile(
                  title: const Text('اسم المستخدم', style: TextStyle(color: Colors.amber, fontSize: 13)),
                  subtitle: Text(messages[index], style: const TextStyle(color: Colors.white)),
                  trailing: const Text('تم المشاهدة ✓✓', style: TextStyle(fontSize: 10, color: Colors.greenAccent)),
                ),
              ),
            ),
            Container(
              color: const Color(0xFF1E293B),
              padding: const EdgeInsets.all(😎,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.card_giftcard, color: Colors.amber),
                    onPressed: _showGiftsDialog,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالة...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      if (_msgController.text.isNotEmpty) {
                        setState(() {
                          messages.add(_msgController.text);
                          _msgController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
