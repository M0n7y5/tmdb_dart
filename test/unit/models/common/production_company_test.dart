import 'package:test/test.dart';
import 'package:tmdb_dart/src/models/common/production_company.dart';

void main() {
  group('ProductionCompany', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON with all fields', () {
        // Arrange
        final json = {
          'id': 12345,
          'name': 'Marvel Studios',
          'logo_path': '/logo_path.jpg',
          'origin_country': 'US',
        };

        // Act
        final company = ProductionCompany.fromJson(json);

        // Assert
        expect(company.id, 12345);
        expect(company.name, 'Marvel Studios');
        expect(company.logoPath, '/logo_path.jpg');
        expect(company.originCountry, 'US');
      });

      test('should handle null/optional fields', () {
        // Arrange
        final json = {
          'id': 12345,
          'name': 'Marvel Studios',
          'logo_path': null,
          'origin_country': null,
        };

        // Act
        final company = ProductionCompany.fromJson(json);

        // Assert
        expect(company.id, 12345);
        expect(company.name, 'Marvel Studios');
        expect(company.logoPath, isNull);
        expect(company.originCountry, isNull);
      });

      test('should handle missing optional fields', () {
        // Arrange
        final json = {
          'id': 12345,
          'name': 'Marvel Studios',
        };

        // Act
        final company = ProductionCompany.fromJson(json);

        // Assert
        expect(company.id, 12345);
        expect(company.name, 'Marvel Studios');
        expect(company.logoPath, isNull);
        expect(company.originCountry, isNull);
      });

      test('should handle empty strings for optional fields', () {
        // Arrange
        final json = {
          'id': 12345,
          'name': 'Marvel Studios',
          'logo_path': '',
          'origin_country': '',
        };

        // Act
        final company = ProductionCompany.fromJson(json);

        // Assert
        expect(company.id, 12345);
        expect(company.name, 'Marvel Studios');
        expect(company.logoPath, '');
        expect(company.originCountry, '');
      });

      test('should throw error when required fields are missing', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act & Assert
        expect(
            () => ProductionCompany.fromJson(json), throwsA(isA<TypeError>()));
      });

      test('should handle special characters in name', () {
        // Arrange
        final json = {
          'id': 12345,
          'name': 'Studio Ghibli, Inc.',
        };

        // Act
        final company = ProductionCompany.fromJson(json);

        // Assert
        expect(company.id, 12345);
        expect(company.name, 'Studio Ghibli, Inc.');
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON with all fields', () {
        // Arrange
        const company = ProductionCompany(
          id: 12345,
          name: 'Marvel Studios',
          logoPath: '/logo_path.jpg',
          originCountry: 'US',
        );

        // Act
        final json = company.toJson();

        // Assert
        expect(json['id'], 12345);
        expect(json['name'], 'Marvel Studios');
        expect(json['logo_path'], '/logo_path.jpg');
        expect(json['origin_country'], 'US');
      });

      test('should correctly serialize to JSON with null fields', () {
        // Arrange
        const company = ProductionCompany(
          id: 12345,
          name: 'Marvel Studios',
        );

        // Act
        final json = company.toJson();

        // Assert
        expect(json['id'], 12345);
        expect(json['name'], 'Marvel Studios');
        expect(json['logo_path'], isNull);
        expect(json['origin_country'], isNull);
      });

      test('should correctly serialize to JSON with empty string fields', () {
        // Arrange
        const company = ProductionCompany(
          id: 12345,
          name: 'Marvel Studios',
          logoPath: '',
          originCountry: '',
        );

        // Act
        final json = company.toJson();

        // Assert
        expect(json['id'], 12345);
        expect(json['name'], 'Marvel Studios');
        expect(json['logo_path'], '');
        expect(json['origin_country'], '');
      });
    });

    group('round-trip', () {
      test(
          'should maintain data integrity through serialization cycle with all fields',
          () {
        // Arrange
        const originalCompany = ProductionCompany(
          id: 12345,
          name: 'Marvel Studios',
          logoPath: '/logo_path.jpg',
          originCountry: 'US',
        );

        // Act
        final json = originalCompany.toJson();
        final deserializedCompany = ProductionCompany.fromJson(json);

        // Assert
        expect(deserializedCompany.id, originalCompany.id);
        expect(deserializedCompany.name, originalCompany.name);
        expect(deserializedCompany.logoPath, originalCompany.logoPath);
        expect(
            deserializedCompany.originCountry, originalCompany.originCountry);
      });

      test(
          'should maintain data integrity through serialization cycle with null fields',
          () {
        // Arrange
        const originalCompany = ProductionCompany(
          id: 12345,
          name: 'Marvel Studios',
        );

        // Act
        final json = originalCompany.toJson();
        final deserializedCompany = ProductionCompany.fromJson(json);

        // Assert
        expect(deserializedCompany.id, originalCompany.id);
        expect(deserializedCompany.name, originalCompany.name);
        expect(deserializedCompany.logoPath, originalCompany.logoPath);
        expect(
            deserializedCompany.originCountry, originalCompany.originCountry);
      });

      test(
          'should maintain data integrity through serialization cycle with empty strings',
          () {
        // Arrange
        const originalCompany = ProductionCompany(
          id: 12345,
          name: 'Marvel Studios',
          logoPath: '',
          originCountry: '',
        );

        // Act
        final json = originalCompany.toJson();
        final deserializedCompany = ProductionCompany.fromJson(json);

        // Assert
        expect(deserializedCompany.id, originalCompany.id);
        expect(deserializedCompany.name, originalCompany.name);
        expect(deserializedCompany.logoPath, originalCompany.logoPath);
        expect(
            deserializedCompany.originCountry, originalCompany.originCountry);
      });
    });

    group('equality', () {
      test('should consider equal companies with same values', () {
        // Arrange
        const company1 = ProductionCompany(
          id: 12345,
          name: 'Marvel Studios',
          logoPath: '/logo_path.jpg',
          originCountry: 'US',
        );
        const company2 = ProductionCompany(
          id: 12345,
          name: 'Marvel Studios',
          logoPath: '/logo_path.jpg',
          originCountry: 'US',
        );

        // Assert
        expect(company1, equals(company2));
      });

      test('should consider different companies with different ids', () {
        // Arrange
        const company1 = ProductionCompany(id: 12345, name: 'Marvel Studios');
        const company2 = ProductionCompany(id: 54321, name: 'Marvel Studios');

        // Assert
        expect(company1, isNot(equals(company2)));
      });

      test('should consider different companies with different names', () {
        // Arrange
        const company1 = ProductionCompany(id: 12345, name: 'Marvel Studios');
        const company2 = ProductionCompany(id: 12345, name: 'DC Comics');

        // Assert
        expect(company1, isNot(equals(company2)));
      });
    });
  });
}
