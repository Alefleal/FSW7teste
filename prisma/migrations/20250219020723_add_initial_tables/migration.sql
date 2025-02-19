/*
  Warnings:

  - You are about to drop the column `CreatedAt` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `productid` on the `OrderProduct` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `OrderProduct` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Product` table. All the data in the column will be lost.
  - The `ingredients` column on the `Product` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `avatarImageurl` on the `Restaurant` table. All the data in the column will be lost.
  - You are about to drop the column `coverImageurl` on the `Restaurant` table. All the data in the column will be lost.
  - Changed the type of `status` on the `Order` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `productId` to the `OrderProduct` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `OrderProduct` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `avatarImageUrl` to the `Restaurant` table without a default value. This is not possible if the table is not empty.
  - Added the required column `coverImageUrl` to the `Restaurant` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('PENDING', 'IN_PREPARATION', 'FINISHED');

-- DropForeignKey
ALTER TABLE "OrderProduct" DROP CONSTRAINT "OrderProduct_productid_fkey";

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "CreatedAt",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
DROP COLUMN "status",
ADD COLUMN     "status" "OrderStatus" NOT NULL;

-- AlterTable
ALTER TABLE "OrderProduct" DROP COLUMN "productid",
DROP COLUMN "updateAt",
ADD COLUMN     "productId" TEXT NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "updateAt",
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
DROP COLUMN "ingredients",
ADD COLUMN     "ingredients" TEXT[];

-- AlterTable
ALTER TABLE "Restaurant" DROP COLUMN "avatarImageurl",
DROP COLUMN "coverImageurl",
ADD COLUMN     "avatarImageUrl" TEXT NOT NULL,
ADD COLUMN     "coverImageUrl" TEXT NOT NULL;

-- DropEnum
DROP TYPE "OrdeStatus";

-- AddForeignKey
ALTER TABLE "OrderProduct" ADD CONSTRAINT "OrderProduct_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;
