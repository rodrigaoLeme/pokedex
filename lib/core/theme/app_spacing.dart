/// Design System - Espaçamentos
///
/// Define todos os espaçamentos usados no app seguindo escala de 4px
/// Garante consistêncua e facilita responsividade.
class AppSpacing {
  // Escala base de 4px
  static const double xxxs = 2.0; // 2px
  static const double xxs = 4.0; // 4px
  static const double xs = 8.0; // 8px
  static const double sm = 12.0; // 12px
  static const double md = 16.0; // 16px (padrão)
  static const double lg = 24.0; // 24px
  static const double xl = 32.0; // 32px
  static const double xxl = 40.0; // 40px
  static const double xxxl = 48.0; // 48px
  static const double huge = 64.0; // 64px

  // Espaçamentos específicos
  static const double cardPadding = md;
  static const double screenPadding = lg;
  static const double listSpacing = xs;
  static const double sectionSpacing = xl;

  // Boder Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Card Específico
  static const double cardRadium = radiusLg;

  // Icon sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  AppSpacing._(); // Construtor privado
}
